# TODO List

- Fix `.u/bin/fbps` script, dnf reinstall breaks. Maybe just simplify the script.
- Check `.u/scripts` since moving archinstall and pacman scripts under `.u/os/` possibly break some scripts.
- Make Sway display dynamic, maybe using Kanshi.
- Create script priority under `.u/scripts/main.sh`. `env.sh` is loaded after `alias.sh`, which means that I can't use custom environment variables under scripts folder.
- Possibly rename `./u/scripts` folder into `./u/config`? since I have `./u/bin` for custom scripts too
