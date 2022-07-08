<style>
    body {
        background-color: rgb(20, 20, 20);
        width: 900px;
        margin: auto;
    }
    * {
        color: white;
    }
</style>

<h1>My Genshin Stats</h1>

<table>
    <tr><td>Nickname</td><td>${record_card.nickname}</td></tr>
    <tr><td>Adventure rank</td><td>${record_card.level}</td></tr>
    <tr><td>Total rewards claimed</td><td>${daily_reward_info.claimed_rewards}</td></tr>
    <tr><td>Last reward</td>
        <td>
            <img src="${last_claimed_reward.icon}" width="120px">
            <br>
            ${last_claimed_reward.amount} x ${last_claimed_reward.name}
        </td>
    </tr>
    <tr><td>Last checked</td><td>${check_time}</td></tr>
</table>

<h2>Stats</h2>

<table>
    <tr><td>Achievements</td><td>${user.stats.achievements}</td></tr>
    <tr><td>Active days</td><td>${user.stats.days_active}</td></tr>
    <tr><td>Characters</td><td>${user.stats.characters}</td></tr>
    <tr><td>Spiral abyss</td><td>${user.stats.spiral_abyss}</td></tr>
    <tr><td>Anemoculi</td><td>${user.stats.anemoculi}</td></tr>
    <tr><td>Geoculi</td><td>${user.stats.geoculi}</td></tr>
    <tr><td>Electroculi</td><td>${user.stats.electroculi}</td></tr>
    <tr><td>Common chests</td><td>${user.stats.common_chests}</td></tr>
    <tr><td>Exquisite chests</td><td>${user.stats.exquisite_chests}</td></tr>
    <tr><td>Precious chests</td><td>${user.stats.precious_chests}</td></tr>
    <tr><td>Luxurious chests</td><td>${user.stats.luxurious_chests}</td></tr>
    <tr><td>Unlocked waypoints</td><td>${user.stats.unlocked_waypoints}</td></tr>
    <tr><td>Unlocked domains</td><td>${user.stats.unlocked_domains}</td></tr>
</table>

<h2>Spiral Abyss</h2>

<%def name="get_character_and_stat(arr, end='')">\
%if len(arr) != 0:
${arr[0].name} -> ${arr[0].value}${end}\
%else:
no data 😥\
%endif
</%def>
<table>
    <tr><td>Total battles</td><td>${user.abyss.current.total_battles}</td></tr>
    <tr><td>Total wins</td><td>${user.abyss.current.total_wins}</td></tr>
    <tr><td>Max floor</td><td>${user.abyss.current.max_floor}</td></tr>
    <tr><td>Total stars</td><td>${user.abyss.current.total_stars}</td></tr>
    <tr><td>Strongest hit</td><td>${get_character_and_stat(user.abyss.current.ranks.strongest_strike, " DMG")}</td></tr>
    <tr><td>Most kills</td><td>${get_character_and_stat(user.abyss.current.ranks.most_kills)}</td></tr>
    <tr><td>Most damage taken</td><td>${get_character_and_stat(user.abyss.current.ranks.most_damage_taken, " DMG")}</td></tr>
    <tr><td>Most skills used</td><td>${get_character_and_stat(user.abyss.current.ranks.most_skills_used)}</td></tr>
    <tr><td>Most bursts used</td><td>${get_character_and_stat(user.abyss.current.ranks.most_bursts_used)}</td></tr>
</table>

<h2>Exploration</h2>

<table>
    <tr>
    %for location in user.explorations:
        <th>${location.name}</th>
    %endfor
    </tr>
    <tr>
    %for location in user.explorations:
        <td><p align="center"><img src="${location.icon}" width="180"></p></td>
    %endfor
    </tr>
    <tr>
    %for location in user.explorations:
        <td>
            <table>
                <tr>
                    <td>Explored</td>
                    <td>${location.explored}%</td>
                </tr>
                <tr>
                    <td>${location.type} level</td>
                    <td>${location.level}</td>
                </tr>
            </table>
        </td>
    %endfor
    </tr>
</table>

<h2>Characters</h2>

%for character in characters:
<table>
    <tr>
        <td><p align="center"><img src="${character.icon}" width="256"></p></td>
        <td><p align="center"><img src="${character.weapon.icon}" width="256"></p></td>
    </tr>
    <tr>
        <td>
            <table>
                <tr><td>Rarity</td><td>${character.rarity}</td></tr>
                <tr><td>Element</td><td>${character.element}</td></tr>
                <tr><td>Level</td><td>${character.level}</td></tr>
                <tr><td>Friendship</td><td>${character.friendship}</td></tr>
                <tr><td>Constellation</td><td>${character.constellation}</td></tr>\
                <%
                    from collections import Counter
                    _artifacts = map(lambda x: f"{x[1]} x {x[0]}", Counter(map(lambda x: x.set.name, character.artifacts)).most_common())
                %>
                <tr><td>Artifacts</td><td>${"<br>".join(_artifacts)}</td></tr>
                <tr><td>Outfits</td><td>${"<br>".join(map(lambda x: x.name, character.outfits))}</td></tr>
            </table>
        </td>
        <td>
            <table>
                <tr><td>Name</td><td>${character.weapon.name}</td></tr>
                <tr><td>Rarity</td><td>${character.weapon.rarity}</td></tr>
                <tr><td>Level</td><td>${character.weapon.level}</td></tr>
                <tr><td>Refinement</td><td>${character.weapon.refinement}</td></tr>
            </table>
        </td>
    </tr>
</table>
%endfor