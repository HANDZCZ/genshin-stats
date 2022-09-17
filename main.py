import asyncio
import os
import genshin
import requests
from mako.template import Template
from deta import Deta, App
from fastapi import FastAPI, status
from fastapi.responses import HTMLResponse
from modules import *

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
    if db.get("DONE") != None:
        return

    COOKIE, GAME_UID, AUTHKEY, WEB_KEY, WEB_URL = setup_env(db)

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

    used_codes = get_used_codes(db)
    codes_to_redeem = get_codes_to_redeem(db, used_codes)
    redeemed_codes = await redeem_codes(db, client, codes_to_redeem)
    user, diary, daily_reward_info, last_claimed_reward, characters, check_time = await get_stats(client, GAME_UID)

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
        data = {'key': WEB_KEY}
        requests.post(WEB_URL, files=files, data=data)

    db.put("Yes", "DONE", expire_in=120)
