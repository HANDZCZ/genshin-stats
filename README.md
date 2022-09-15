# Genshin stats

Repository that hosts code to show my genshin stats.\
Automatically claims:
- daily reward
- active primo codes (from <https://www.pockettactics.com/genshin-impact/codes>)

[My stats](https://genshin.handz.us.to/)

# ❗NOTICE❗

Once heroku removes free tier at 28.11.2022 or sooner, then this branch will no longer be supported. It will be deleted and replaced by deta branch.

Also deta branch is now in testing phase so it won't be that long (few days or weeks).

# Setup

You will need to have or create heroku account and some website hosting that supports php scripts.

## GitHub

1. Fork this repo
1. Change website url
   1. Click the pen icon\
      ![image](https://user-images.githubusercontent.com/35496843/178002976-8c978699-cd1c-43cc-be9a-da098d516972.png)
   1. Edit ``8th`` line to ``[My stats](YOUR_WEBSITE_URL)`` 

## Website

Use some free hosting or your own.

1. Edit ``index.php``
   1. Change ``$KEY=""`` to ``$KEY="SOME_GENERATED_KEY"`` (eg. ``$KEY="f54as65f156a1f6as156dc156asc61asd56a64f65as46f4as6d"``)
1. Upload file ``index.php``
1. Load the page and make sure it's not showing any errors, you should see a blank page or a warning that page.html is missing

## Heroku

1. Create account if you don't have one
1. On [dashboard](https://dashboard.heroku.com/apps) click New-> Create new app
   ![image](https://user-images.githubusercontent.com/35496843/177956811-e6e5d30c-063c-47a4-b260-21bcd8213391.png)
1. Name it whatever, choose a region and click ``Create app``
1. In the ``Deploy`` tab click ``GitHub``\
   You will need to authorize heroku. That should be simple.
1. Click ``Search`` find genshin-stats repo and click ``Connect``
   ![image](https://user-images.githubusercontent.com/35496843/177958036-5a40ac57-d645-45b7-8ab2-aa686b0fe527.png)
1. Enable automatic deploys on main branch
   ![image](https://user-images.githubusercontent.com/35496843/177958451-9be0610b-af35-405b-8bcf-04699d781605.png)
1. Configure dyno and addons
   1. Uncheck the switch if its on.\
      ![image](https://user-images.githubusercontent.com/35496843/177959514-1372396d-c25e-46a7-927a-9b24cb65135e.png)
   1. Click ``Change Dyno Type`` and make sure it's on ``Free`` if not change it
      ![image](https://user-images.githubusercontent.com/35496843/177960179-dd808431-031d-4666-88f0-bb3bb4cfb15c.png)
   1. In addons search for ``heroku scheduler`` and click on it
      ![image](https://user-images.githubusercontent.com/35496843/177960454-83f896ec-96c5-4e3d-84e2-bd8399b88f07.png)
   1. Click ``Submit Order Form``\
      If you don't have verified account this won't work!

      For verification you will need to add a payment method.\
      Don't worry you won't be charged anything.\
      After that you will have 1000 free dyno hours per month.\
      I am running app that runs for about 30 seconds every hour and it uses at max 6 hours a month.\
      So you will be fine.

      If you can't verify your account skip to ``Configure environment variables``, but if you can verify it definitely do that. It's a much better approach.

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
   1. Set key to ``WEB_KEY`` and value to the generated key you created when you were editing ``index.php``
   1. Set key to ``WEB_URL`` and value to your web url
1. Add a buildpack\
      ![image](https://user-images.githubusercontent.com/35496843/178105612-9c18a2a1-b4af-4828-a677-e72aa882fc02.png)
   1. Click ``Add buildpack``
   1. Paste ``https://github.com/HANDZCZ/heroku-buildpack-run.git`` into ``Enter Buildpack URL``
      ![image](https://user-images.githubusercontent.com/35496843/178105733-0132fb31-5675-425d-939f-81bbfa2fcdb3.png)
   1. Click ``Save chages``
   1. Make sure that ``heroku/python`` is first
      ![image](https://user-images.githubusercontent.com/35496843/178105838-150a4a80-102e-4038-a1d0-156be061c8bd.png)

1. In ``Deploy`` tab run manual deploy
   ![image](https://user-images.githubusercontent.com/35496843/177958719-bb6d437e-23d4-4c31-a814-c2ef3000e4ca.png)
   Wait for it to finish
   ![image](https://user-images.githubusercontent.com/35496843/177959041-54fdca93-8e4d-42bf-9bf6-3d9379d231c5.png)

## For those who can't verify their account

### GitHub

1. Edit ``Procfile``\
   Uncomment ``web: ...`` and comment out ``bot: ...``
   Should look something like this after you do this step\
   ```Procfile
   #bot: python3 main.py
   web: python3 main_web.py
   ```

### Heroku

1. Switch on web dyno
   1. Go to ``Resources`` tab
   1. Under ``Free dynos`` you should see ``web python3 ...``
   1. On the right click pen icon
   1. Switch it on
   1. Click save

1. Get your heroku url by clicking ``Open app`` in the top right corner.

### Cron service

You can use something like ``cron-job.org/en/``

1. Set the url to your heroku app
1. Run it every day at ``16:30 UTC`` make sure it runs at ``16:30 UTC`` otherwise the app will not update you stats.\
   It only accepts requests for updating your stats between ``16:10 UTC`` and ``16:40 UTC``\
   For example ``cron-job.org/en/`` shows and sets the scheduled time in you timezone.\
   If you end up using it, then set the scheduled time to ``16:30`` plus your UTC offset.\
   You can find your offset by searching ``London utc time offset``
