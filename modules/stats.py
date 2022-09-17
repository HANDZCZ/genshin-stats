import genshin
import datetime
from genshin.models.genshin.chronicle.stats import FullGenshinUserStats

async def get_stats(client, GAME_UID):
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

    return (user, diary, daily_reward_info, last_claimed_reward, characters, check_time)
