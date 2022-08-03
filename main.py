import asyncio
from itertools import count
import logging
import os
import genshin
import io
import datetime
import requests
import time
from bs4 import BeautifulSoup
from mako.template import Template

# AAAAAAAAAAA
from genshin.models.genshin.chronicle.stats import FullGenshinUserStats


async def main():
    hoyolab_uid = os.environ.get("COOKIE").split("ltuid=")[1].split(";")[0]
    game_uid = int(os.environ.get("GAME_UID"))
    client = genshin.Client(
        cookies=os.environ.get("COOKIE"),
        game=genshin.Game.GENSHIN,
        uid=game_uid,
    )
    try:
        client.set_authkey(
            genshin.utility.extract_authkey(os.environ.get("AUTHKEY"))
        )
    except:
        pass

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

    # Code redeem
    # Get active codes
    res = requests.get("https://www.pockettactics.com/genshin-impact/codes")
    soup = BeautifulSoup(res.text, 'html.parser')

    active_codes = [code.text.strip() for code in soup.find(
        "div", {"class": "entry-content"}).find("ul").findAll("strong")]

    # Redeem codes
    print("[Code redeem] ", end="")
    redeemed_codes = []
    for code in active_codes[:-1]:
        try:
            await client.redeem_code(code)
            redeemed_codes.append(code)
        except Exception:
            pass
        time.sleep(5.2)
    if len(active_codes) != 0:
        try:
            await client.redeem_code(active_codes[-1])
            redeemed_codes.append(code)
        except Exception:
            pass

    if len(redeemed_codes) != 0:
        print("Redeemed " + str(len(redeemed_codes)) +
              " new codes: " + ", ".join(redeemed_codes))
    else:
        print("No new codes found")

    # await client.check_in_community()
    user: FullGenshinUserStats = await client.get_full_genshin_user(game_uid)
    diary = await client.get_diary()

    # Characters
    characters = list(user.characters)
    characters.sort(key=lambda x: (int(x.rarity), int(x.level), int(
        x.constellation), int(x.friendship)), reverse=True)

    # Check time
    check_time = datetime.datetime.utcnow().strftime("%d.%m.%Y %H:%M:%S UTC")

    # Render template
    page = Template(filename="./template.mako", module_directory="./mako_modules").render(
        user=user,
        diary=diary,
        daily_reward_info=daily_reward_info,
        last_claimed_reward=last_claimed_reward,
        characters=characters,
        check_time=check_time,
        redeemed_codes=redeemed_codes,
    )

    files = {'file': page}
    data = {'key': os.environ.get("WEB_KEY")}
    requests.post(os.environ.get("WEB_URL"), files=files, data=data)

if __name__ == "__main__":
    asyncio.run(main())
