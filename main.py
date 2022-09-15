import asyncio
import os
import genshin
import datetime
import requests
import time
from bs4 import BeautifulSoup
from mako.template import Template
from deta import Deta, App
from fastapi import FastAPI, status
from fastapi.responses import HTMLResponse

# AAAAAAAAAAA
from genshin.models.genshin.chronicle.stats import FullGenshinUserStats

app = App(FastAPI())
deta = Deta(os.environ.get("DETA_PROJECT_KEY"))
db = deta.Base("genshin-stats")

@app.get("/")
async def root():
    page = db.get("RENDERED_PAGE")
    if page == None:
        return HTMLResponse("<h1>Nothing yet 😞</h1>", status_code=status.HTTP_404_NOT_FOUND)
    return HTMLResponse(page["value"])

@app.get("/force-refresh")
async def force():
    await update_stats()
    return HTMLResponse("<h1>🚀 OK 👍</h1>")

@app.lib.cron()
def cron(event):
    asyncio.run(update_stats())

async def update_stats():
    # setup env variables
    COOKIE = db.get("COOKIE")
    if COOKIE == None:
        COOKIE = os.environ.get("COOKIE")
        db.put(COOKIE, "COOKIE")
    else:
        COOKIE = COOKIE["value"]

    GAME_UID = db.get("GAME_UID")
    if GAME_UID == None:
        GAME_UID = int(os.environ.get("GAME_UID"))
        db.put(GAME_UID, "GAME_UID")
    else:
        GAME_UID = GAME_UID["value"]

    AUTHKEY = db.get("AUTHKEY")
    if AUTHKEY == None:
        AUTHKEY = os.environ.get("AUTHKEY")
        db.put(AUTHKEY, "AUTHKEY")
    else:
        AUTHKEY = AUTHKEY["value"]

    WEB_KEY = db.get("WEB_KEY")
    if WEB_KEY == None:
        WEB_KEY = os.environ.get("WEB_KEY")
        db.put(WEB_KEY, "WEB_KEY")
    else:
        WEB_KEY = WEB_KEY["value"]

    WEB_URL = db.get("WEB_URL")
    if WEB_URL == None:
        WEB_URL = os.environ.get("WEB_URL")
        db.put(WEB_URL, "WEB_URL")
    else:
        WEB_URL = WEB_URL["value"]


    #hoyolab_uid = os.environ.get("COOKIE").split("ltuid=")[1].split(";")[0]
    client = genshin.Client(
        cookies=COOKIE,
        game=genshin.Game.GENSHIN,
        uid=GAME_UID,
    )
    try:
        client.set_authkey(
            genshin.utility.extract_authkey(AUTHKEY)
        )
    except:
        pass

    step = db.get("STEP")
    if step == None:
        step = 1
    else:
        step = step["value"]

    if step == 1:
        used_codes = db.get("USED_CODES")
        if used_codes == None:
            used_codes = []
            db.put(used_codes, "USED_CODES")
        else:
            used_codes = used_codes["value"]

        # Code redeem
        # Get active codes
        res = requests.get("https://www.pockettactics.com/genshin-impact/codes")
        soup = BeautifulSoup(res.text, 'html.parser')

        active_codes = [code.text.strip() for code in soup.find(
            "div", {"class": "entry-content"}).find("ul").findAll("strong")]
        active_codes = list(filter(lambda code: code not in used_codes, active_codes))

        db.put(active_codes, "ACTIVE_CODES", expire_in=1200)
        step = 2
        db.put(step, "STEP", expire_in=1200)

    if step == 2:
        redeemed_codes = db.get("REDEEMED_CODES")
        if redeemed_codes == None:
            redeemed_codes = []
            db.put(redeemed_codes, "REDEEMED_CODES", expire_in=1200)

        active_codes = db.get("ACTIVE_CODES")["value"]
        used_codes = db.get("USED_CODES")["value"]
        active_codes = list(filter(lambda code: code not in used_codes, active_codes))


        # Redeem codes
        for code in active_codes[:-1]:
            try:
                await client.redeem_code(code)
                db.update({ "value": db.util.append(code) }, "REDEEMED_CODES")
            except Exception:
                pass
            db.update({ "value": db.util.append(code) }, "USED_CODES")
            time.sleep(5.2)
        if len(active_codes) != 0:
            try:
                await client.redeem_code(active_codes[-1])
                db.update({ "value": db.util.append(active_codes[-1]) }, "REDEEMED_CODES")
            except Exception:
                pass
            db.update({ "value": db.util.append(active_codes[-1]) }, "USED_CODES")

        redeemed_codes = db.get("REDEEMED_CODES")["value"]
        print("[Code redeem] ", end="")
        if len(redeemed_codes) != 0:
            print("Redeemed " + str(len(redeemed_codes)) +
                " new codes: " + ", ".join(redeemed_codes))
        else:
            print("No new codes found")

        step = 3
        db.put(step, "STEP", expire_in=1200)

    if step == 3:
        # Daily reward
        print("[Daily Reward] ", end="")
        try:
            await client.claim_daily_reward(reward=False)
            _claimed = True
        except genshin.AlreadyClaimed:
            print("Already claimed")
            _claimed = False

        daily_reward_info = await client.get_reward_info()
        last_claimed_reward = await client.claimed_rewards().next()
        if _claimed:
            print(
                f"Claimed: {last_claimed_reward.amount} x {last_claimed_reward.name}"
            )

        # await client.check_in_community()
        user: FullGenshinUserStats = await client.get_full_genshin_user(GAME_UID)
        diary = await client.get_diary()

        # Characters
        characters = list(user.characters)
        characters.sort(key=lambda x: (int(x.rarity), int(x.level), int(
            x.constellation), int(x.friendship)), reverse=True)

        # Check time
        check_time = datetime.datetime.utcnow().strftime("%d.%m.%Y %H:%M:%S UTC")

        redeemed_codes = db.get("REDEEMED_CODES")["value"]

        # Render template
        page = Template(filename="./template.mako", module_directory="/tmp/mako_modules").render(
            user=user,
            diary=diary,
            daily_reward_info=daily_reward_info,
            last_claimed_reward=last_claimed_reward,
            characters=characters,
            check_time=check_time,
            redeemed_codes=redeemed_codes,
        )
        db.put(page, "RENDERED_PAGE")

        if WEB_KEY != None and WEB_URL != None:
            files = {'file': page}
            data = {'key': os.environ.get("WEB_KEY")}
            requests.post(os.environ.get("WEB_URL"), files=files, data=data)

        step = 4
        db.put(step, "STEP", expire_in=1200)

