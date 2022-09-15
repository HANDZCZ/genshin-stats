# Genshin stats

Repository that hosts code to show my genshin stats.\
Automatically claims:
- daily reward
- active primo codes (from <https://www.pockettactics.com/genshin-impact/codes>)

[My stats](https://genshin.handz.us.to/)

[![Deploy](https://button.deta.dev/1/svg)](https://go.deta.dev/deploy?repo=https://github.com/HANDZCZ/genshin-stats/tree/deta)


# Setup

You will need to have or create [Deta account](https://web.deta.sh/) and optionally some website hosting that supports php scripts.


## Deta

1. Create account if you don't have one
1. [![Deploy](https://button.deta.dev/1/svg)](https://go.deta.dev/deploy?repo=https://github.com/HANDZCZ/genshin-stats/tree/deta)
1. Configure environment variables
   1. Set key to ``GAME_UID`` and value to your UID in game
   1. Set ``COOKIE``
      1. Go to <https://www.hoyolab.com/>.
      1. Login to your account.
      1. Press F12 to open Inspect Mode (ie. Developer Tools).
      1. Go to ``Console``
      1. run ``copy(document.cookie)``\
         ![image](https://user-images.githubusercontent.com/35496843/177964372-27a455e8-d7e5-4fb7-bd40-c91b657dc538.png)
   1. (Optional) Set key to ``WEB_KEY`` and value to the generated key you created when you were editing ``index.php``
   1. (Optional) Set key to ``WEB_URL`` and value to your web url
1. Go to the URL it gives you and add ``/force-refresh`` after it (e.g. ``https://dawdad.deta.dev/force-refresh``).\
   It should take a while to load and either say it timed out or ``OK``.\
   If it says timed out, then refresh until it doesn't.


## Website (optional)

Use some free hosting or your own.

1. Edit ``index.php``
   1. Change ``$KEY=""`` to ``$KEY="SOME_GENERATED_KEY"`` (eg. ``$KEY="f54as65f156a1f6as156dc156asc61asd56a64f65as46f4as6d"``)
1. Upload file ``index.php``
1. Load the page and make sure it's not showing any errors, you should see a blank page or a warning that page.html is missing

