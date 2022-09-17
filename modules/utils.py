import os

# setup env variables
def setup_env(db):
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

    return (COOKIE, GAME_UID, AUTHKEY, WEB_KEY, WEB_URL)



def get_used_codes(db):
    used_codes = db.get("USED_CODES")
    if used_codes == None:
        used_codes = []
        db.put(used_codes, "USED_CODES")
    else:
        used_codes = used_codes["value"]
    return used_codes
