import time

async def redeem_codes(db, client, codes_to_redeem):
    redeemed_codes = db.get("REDEEMED_CODES")
    if redeemed_codes == None:
        redeemed_codes = []
        db.put(redeemed_codes, "REDEEMED_CODES", expire_in=1200)
    elif len(codes_to_redeem) == 0:
        return redeemed_codes["value"]

    # Redeem codes
    for code in codes_to_redeem[:-1]:
        await _redeem_code(code, db, client)
        time.sleep(5.2)
    if len(codes_to_redeem) != 0:
        await _redeem_code(codes_to_redeem[-1], db, client)

    redeemed_codes = db.get("REDEEMED_CODES")["value"]
    print("[Code redeem] ", end="")
    if len(redeemed_codes) != 0:
        print("Redeemed " + str(len(redeemed_codes)) +
            " new codes: " + ", ".join(redeemed_codes))
    else:
        print("No new codes found")

    return redeemed_codes

async def _redeem_code(code, db, client):
    try:
        await client.redeem_code(code)
        db.update({ "value": db.util.append(code) }, "REDEEMED_CODES")
    except Exception:
        pass
    db.update({ "value": db.util.append(code) }, "USED_CODES")



import requests
from bs4 import BeautifulSoup

def get_codes_to_redeem(db, used_codes):
    active_codes = db.get("ACTIVE_CODES")
    if active_codes != None:
        return list(filter(lambda code: code not in used_codes, active_codes["value"]))

    res = requests.get("https://www.pockettactics.com/genshin-impact/codes")
    soup = BeautifulSoup(res.text, 'html.parser')

    active_codes = [code.text.strip() for code in soup.find(
        "div", {"class": "entry-content"}).find("ul").findAll("strong")]
    db.put(active_codes, "ACTIVE_CODES", expire_in=1200)

    codes_to_redeem = list(filter(lambda code: code not in used_codes, active_codes))

    return codes_to_redeem
