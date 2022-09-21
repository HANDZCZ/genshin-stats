<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.14.3/css/uikit.min.css"
        integrity="sha512-iWrYv6nUp7gzf+Ut/gMjxZn+SWdaiJYn+ZZNq63t2JO6kBpDc40wQfBzC1eOAzlwIMvRyuS974D1R8p1BTdaUw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            background-color: #545454;
        }

        .uk-navbar-container.uk-light:not(.uk-navbar-transparent):not(.uk-navbar-primary) {
            background: #222;
        }

        .uk-dropdown.uk-light {
            background: #222;
        }

        .uk-dropdown li {
            padding-left: 5px;
            border-left: 2px solid transparent;
        }

        .uk-dropdown li.uk-active {
            border-color: #545454;
        }

        #mobile-navbar li {
            padding-left: 5px;
            border-left: 2px solid transparent;
        }

        #mobile-navbar li.uk-active {
            border-color: #545454;
        }

        .uk-navbar a {
            text-decoration: none
        }

        .uk-form-danger {
            color: #f0506e !important;
            border-color: #f0506e !important;
        }

        .uk-notification-message {
            background: #222;
        }

        .uk-icon[uk-icon="icon: star; ratio: 2"] polygon {
            fill: gold;
            stroke: none !important;
        }

        .keep-visible-hover:not(:hover) {
            display: none;
        }

        .uk-visible {
            display: block !important;
        }

        .outfit {
            position: absolute;
            top: 0;
        }

        @media (pointer: coarse) {
            .uk-background-fixed {
                background-attachment: fixed;
            }
        }

        .body-background {
            background-image: url('https://source.unsplash.com/0y6Y56Pw6DA/1920x1080')
        }

        @media (max-width: 1199px) {
            .body-background {
                background: black;
            }
        }
    </style>
    <title>Document</title>
</head>

<body>
    <div class="uk-background-fixed uk-height-viewport uk-background-cover uk-background-norepeat body-background">

        <nav class="uk-navbar-container uk-light" uk-navbar>
            <div class="uk-navbar-left">
                <a href="https://github.com/HANDZCZ/genshin-stats" class="uk-navbar-item">Get your own</a>
            </div>
            <div class="uk-navbar-center">
                <a href="https://github.com/HANDZCZ/genshin-stats" class="uk-navbar-item uk-logo">Genshin stats</a>
            </div>
            <div class="uk-navbar-right">
                <a href="https://github.com/HANDZCZ/genshin-stats" class="uk-navbar-item">You like?</a>
            </div>
        </nav>

        <div class="uk-container uk-container-xlarge uk-margin-medium-top uk-padding-remove">
            <article class="uk-article uk-section-secondary uk-padding">
                <h1 class="uk-article-title uk-text-center">${user.info.nickname}</h1>
            </article>

            <article class="uk-article uk-padding uk-margin-remove-top">
                <div class="uk-child-width-1-2@l uk-child-width-1-2@m uk-child-width-1-1@s uk-flex-center" uk-grid="masonry: false">
                    <div>
                        <div class="uk-card uk-card-secondary">
                            <div class="uk-card-body">
                                <table class="uk-table uk-table-divider">
                                    <tr><td>Adventure rank</td><td>${user.info.level}</td></tr>
                                    <tr><td>Total rewards claimed</td><td>${daily_reward_info.claimed_rewards}</td></tr>
                                    <tr><td>Last reward</td>
                                        <td>
                                            <img src="${last_claimed_reward.icon}">
                                            <br>
                                            ${last_claimed_reward.amount} x ${last_claimed_reward.name}
                                        </td>
                                    </tr>
                                    <tr><td>Last checked</td><td>${check_time}</td></tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="uk-card uk-card-secondary">
                            <div class="uk-card-body">
                                <table class="uk-table uk-table-divider">
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
                            </div>
                        </div>
                    </div>
                </div>
            </article>

            <article class="uk-article uk-section-secondary uk-padding">
                <h1 class="uk-article-title uk-text-center">Spiral Abyss</h1>
            </article>
            <%def name="get_character_and_stat(arr, end='')">\
                ${format_character(arr[0], end)}\
            </%def>
            <%def name="format_character(character, end='')">\
                ${character.name} -> ${character.value}${end}\
            </%def>
            <article class="uk-article uk-padding uk-margin-remove-top">
                <div class="uk-child-width-1-3@l uk-child-width-1-2@m uk-child-width-1-1@s uk-text-center uk-flex-center" uk-grid="masonry: false">
                    <div>
                        <div class="uk-card uk-card-secondary">
                            <div class="uk-card-body">
                                <table class="uk-table uk-table-divider">
                                    <tr><td>Total battles</td><td>${user.abyss.current.total_battles}</td></tr>
                                    <tr><td>Total wins</td><td>${user.abyss.current.total_wins}</td></tr>
                                    <tr><td>Max floor</td><td>${user.abyss.current.max_floor}</td></tr>
                                    <tr><td>Total stars</td><td>${user.abyss.current.total_stars}</td></tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    %if user.abyss.current.total_battles > 0:
                        <div>
                            <div class="uk-card uk-card-secondary">
                                <div class="uk-card-body">
                                    <h3 class="uk-card-title">Strongest hit</h3>
                                    <p>${get_character_and_stat(user.abyss.current.ranks.strongest_strike, " DMG")}</p>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="uk-card uk-card-secondary">
                                <div class="uk-card-body">
                                    <h3 class="uk-card-title">Most kills</h3>
                                    <p>${get_character_and_stat(user.abyss.current.ranks.most_kills)}</p>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="uk-card uk-card-secondary">
                                <div class="uk-card-body">
                                    <h3 class="uk-card-title">Most damage taken</h3>
                                    <p>${get_character_and_stat(user.abyss.current.ranks.most_damage_taken, " DMG")}</p>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="uk-card uk-card-secondary">
                                <div class="uk-card-body">
                                    <h3 class="uk-card-title">Most skills used</h3>
                                    <p>${get_character_and_stat(user.abyss.current.ranks.most_skills_used)}</p>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="uk-card uk-card-secondary">
                                <div class="uk-card-body">
                                    <h3 class="uk-card-title">Most bursts used</h3>
                                    <p>${get_character_and_stat(user.abyss.current.ranks.most_bursts_used)}</p>
                                </div>
                            </div>
                        </div>
                    %endif
                </div>
            </article>

            <article class="uk-article uk-section-secondary uk-padding">
                <h1 class="uk-article-title uk-text-center">Exploration</h1>
            </article>

            <article class="uk-article uk-padding uk-margin-remove-top">
                <div class="uk-child-width-1-3@l uk-child-width-1-2@m uk-child-width-1-1@s uk-text-center uk-flex-center" uk-grid="masonry: false">
                    %for location in user.explorations:
                        <div>
                            <div class="uk-card uk-card-secondary">
                                <div class="uk-card-body">
                                    <h3 class="uk-card-title">${location.name}</h3>
                                    <img src="${location.icon}">
                                    <table class="uk-table uk-table-divider">
                                        <tr><td>Explored</td><td>${location.explored}%</td></tr>
                                        <tr><td>${location.type} level</td><td>${location.level}</td></tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    %endfor
                </div>
            </article>

            <article class="uk-article uk-section-secondary uk-padding">
                <h1 class="uk-article-title uk-text-center">Characters</h1>
            </article>

<%def name="get_element_icon_url(element)">\
%if element == "Pyro":
https://act.hoyolab.com/app/community-game-records-sea/images/UI_Buff_Element_Fire.864dadd8.png\
%elif element == "Hydro":
https://act.hoyolab.com/app/community-game-records-sea/images/UI_Buff_Element_Water.d492097a.png\
%elif element == "Electro":
https://act.hoyolab.com/app/community-game-records-sea/images/UI_Buff_Element_Elect.cc253e18.png\
%elif element == "Anemo":
https://act.hoyolab.com/app/community-game-records-sea/images/UI_Buff_Element_Wind.214c97ef.png\
%elif element == "Cryo":
https://act.hoyolab.com/app/community-game-records-sea/images/UI_Buff_Element_Frost.f5bc0120.png\
%elif element == "Geo":
https://act.hoyolab.com/app/community-game-records-sea/images/UI_Buff_Element_Roach.17496428.png\
%endif
</%def>

            <article class="uk-article uk-padding uk-margin-remove-top">
                <div class="uk-child-width-1-2@l uk-child-width-1-2@m uk-child-width-1-1@s uk-flex-center" uk-grid="masonry: false">
                    %for character in characters:
                        <div>
                            <div class="uk-card uk-card-secondary">
                                <div class="uk-card-body">


                                        <div class="uk-grid-collapse uk-flex-first@s uk-child-width-1-2@s" uk-grid>
                                            <div class="uk-flex-first@s">
                                                <h3 class="uk-card-title uk-text-center uk-hidden@m"><img src="${get_element_icon_url(character.element)}"> ${character.name}</h3>
                                                <div class="uk-visible@m">
                                                    <img class="uk-align-center" src="${character.image}">
                                                </div>
                                                <div class="uk-hidden@m">
                                                    <img class="uk-align-center" src="${character.icon}">
                                                </div>
                                            </div>

                                            <div>
                                                <h3 class="uk-card-title uk-text-center uk-visible@m"><img src="${get_element_icon_url(character.element)}"> ${character.name}</h3>
                                                <table class="uk-table uk-table-divider">
                                                    <tr><td colspan="2" class="uk-text-center">
                                                        %for _ in range(character.rarity):
                                                            <span class="uk-margin-small-right" uk-icon="icon: star; ratio: 2"></span>
                                                        %endfor
                                                    </td></tr>
                                                    <tr><td>Level</td><td>${character.level}</td></tr>
                                                    <tr><td>Friendship</td><td>${character.friendship}</td></tr>
                                                    <tr><td>Constellation</td><td>${character.constellation}</td></tr>
                                                    <%
                                                        from collections import Counter
                                                        _artifacts = list(map(lambda x: f"{x[1]} x {x[0]}", Counter(map(lambda x: x.set.name, character.artifacts)).most_common()))
                                                    %>
                                                    %if len(_artifacts) > 0:
                                                        <tr><td colspan="2">${"<hr class=\"uk-margin-remove\">".join(_artifacts)}</td></tr>
                                                    %endif
                                                    %if len(character.outfits) > 0:
                                                        <tr><td colspan="2" class="uk-text-center">
                                                            <h4>Outfits</h4>
                                                            <%def name="format_outfit(outfit)">\
                                                                <p uk-toggle="target: [id='${outfit.id}']; cls: uk-visible; mode: hover">${outfit.name}</p>
                                                            </%def>
                                                            %for outfit in character.outfits[:-1]:
                                                                ${format_outfit(outfits[-1])}
                                                                <hr class="uk-margin-remove">
                                                            %endfor
                                                            ${format_outfit(character.outfits[-1])}
                                                        </td></tr>
                                                    %endif
                                                </table>
                                                %for outfit in character.outfits:
                                                    <div class="keep-visible-hover uk-position-z-index outfit" id="${outfit.id}">
                                                        <img src="${outfit.icon}">
                                                    </div>
                                                %endfor
                                            </div>
                                        </div>

                                        <div class="uk-grid-collapse uk-child-width-1-2@s" uk-grid>
                                            <div class="uk-flex-first@s">
                                                <h3 class="uk-card-title uk-text-center uk-hidden@m">${character.weapon.name}</h3>
                                                <img class="uk-align-center" src="${character.weapon.icon}">
                                            </div>

                                            <div>
                                                <h3 class="uk-card-title uk-text-center uk-visible@m">${character.weapon.name}</h3>
                                                <table class="uk-table uk-table-divider">
                                                    <tr><td colspan="2" class="uk-text-center">
                                                        %for _ in range(character.weapon.rarity):
                                                            <span class="uk-margin-small-right" uk-icon="icon: star; ratio: 2"></span>
                                                        %endfor
                                                    </td></tr>
                                                    <tr><td>Level</td><td>${character.weapon.level}</td></tr>
                                                    <tr><td>Refinement</td><td>${character.weapon.refinement}</td></tr>
                                                </table>
                                            </div>
                                        </div>

                                </div>
                            </div>
                        </div>
                    %endfor
                </div>
            </article>
        </div>

    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.14.3/js/uikit.min.js"
        integrity="sha512-wqamZDJQvRHCyy5j5dfHbqq0rUn31pS2fJeNL4vVjl0gnSVIZoHFqhwcoYWoJkVSdh5yORJt+T9lTdd8j9W4Iw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.14.3/js/uikit-icons.min.js"
        integrity="sha512-EPxIFpzTUuEV2uy6q5GHCUlsLWHIzASsy7RQ480ZlVFtjyYhWVACTL0ozarU8GrIRhrQkd/DTHzSSrRQzxPooA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>

</html>