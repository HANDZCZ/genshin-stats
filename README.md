# Genshin stats

Repository that hosts code to show my genshin stats.\
Automatically claims:
- daily reward
- active primo codes (from <https://www.pockettactics.com/genshin-impact/codes>)

[My stats](http://handz-genshin-stats.euweb.cz/)

# Setup

## GitHub

1. Fork this repo
1. Change website url
   1. Click the pen icon\
      ![image](https://user-images.githubusercontent.com/35496843/178002976-8c978699-cd1c-43cc-be9a-da098d516972.png)
   1. Edit ``8th`` line to ``[My stats](YOUR_WEBSITE_URL)`` 

## Website

Use some free hosting or your own.

1. Upload file ``index.php``
1. Upload file named ``key`` that has some generated key (``f54as65f156a1f6as156dc156asc61asd56a64f65as46f4as6d``)

## Heroku

1. Create account if you don't have one
1. You will probably need to add payment method.\
   Don't worry you won't be charged anything.\
   After that you will have 1000 free dyno hours per month.\
   I am running app that runs for about 30 seconds every hour and it uses at max 6 hours a month.\
   So you will be fine.
1. On [dashboard](https://dashboard.heroku.com/apps) click New-> Create new app
   ![image](https://user-images.githubusercontent.com/35496843/177956811-e6e5d30c-063c-47a4-b260-21bcd8213391.png)
1. Name it whatever, choose a region and click ``Create app``
1. In the ``Deploy`` tab click ``GitHub``\
   You will need to authorize heroku. That should be simple.
1. Click ``Search`` find genshin-stats repo and click ``Connect``
   ![image](https://user-images.githubusercontent.com/35496843/177958036-5a40ac57-d645-45b7-8ab2-aa686b0fe527.png)
1. Enable automatic deploys on main branch
   ![image](https://user-images.githubusercontent.com/35496843/177958451-9be0610b-af35-405b-8bcf-04699d781605.png)
1. Run manual deploy
   ![image](https://user-images.githubusercontent.com/35496843/177958719-bb6d437e-23d4-4c31-a814-c2ef3000e4ca.png)
   Wait for it to finish
   ![image](https://user-images.githubusercontent.com/35496843/177959041-54fdca93-8e4d-42bf-9bf6-3d9379d231c5.png)
1. Configure dyno and addons
   1. Uncheck the switch if its on.\
      ![image](https://user-images.githubusercontent.com/35496843/177959514-1372396d-c25e-46a7-927a-9b24cb65135e.png)
   1. Click ``Change Dyno Type`` and make sure it's on ``Free`` if not change it
      ![image](https://user-images.githubusercontent.com/35496843/177960179-dd808431-031d-4666-88f0-bb3bb4cfb15c.png)
   1. In addons search for ``heroku scheduler`` and click on it
      ![image](https://user-images.githubusercontent.com/35496843/177960454-83f896ec-96c5-4e3d-84e2-bd8399b88f07.png)
   1. Click ``Submit Order Form``\
      ![image](https://user-images.githubusercontent.com/35496843/177961065-fd1cc737-68aa-4be9-88be-0af61ad89d5b.png)
1. Configure ``Heroku Scheduler``
   1. Click on ``Heroku Scheduler`` (in Resources tab)
   1. Click ``Create job``
   1. Set it to run every day at ``4:30 PM`` and command to ``python3 main.py`` (you should also see the dyno as ``Free``)
   ![image](https://user-images.githubusercontent.com/35496843/177962000-db2e6a90-b20f-424c-8f50-d3d772de6a2d.png)
   1. Click ``Save Job``
1. Configure environment variables
   1. Go to ``Setting`` (in the app not your profile)
   1. In ``Config Vars`` click ``Reveal Config Vars``
   1. Set key to ``GAME_UID`` and value to your UID in game
   1. Set ``COOKIE``
      1. Go to <https://www.hoyolab.com/>.
      1. Login to your account.
      1. Press F12 to open Inspect Mode (ie. Developer Tools).
      1. Go to ``Console``
      1. run ``copy(document.cookie)``\
         ![image](https://user-images.githubusercontent.com/35496843/177964372-27a455e8-d7e5-4fb7-bd40-c91b657dc538.png)
      1. Paste it into value on heroku.
   1. Set key to ``WEB_KEY`` and value to the uploaded key on website
   1. Set key to ``WEB_URL`` and value to your web url

