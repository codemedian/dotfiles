# DotFiles 

# VIM
To be written

# TMUX
To be written

# Weechat
To be written

## Credentials
In order for the checked in weechat config to work, the following passwords need to be set for the associated accounts
| Server   |      User     | password variable |
|----------|:-------------:|------------------:|
| Freenode |    deadc0de   |     `freenode_pw` |
| Mozilla  |    deadc0de   |      `mozilla_pw` |

# Urxvt
To be written


# Perforce
To be written

# LINE
At the time of writing, line is only available for Linux as a chrome extension. To make it play nice without having to go via chrome, the following desktop file can be added

Find the extension id by going to chrome://extensions, open click on details of the desired extension and check the URL. Extensions should be installed into `~/.local/google-chome/Default/Extensions/` which is another way to obtain the extensions ID
```
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Terminal=false
Type=Application
Name=LINE
Exec=/opt/google/chrome/google-chrome --profile-directory=Default --app=chrome-extension:{extension-id}/index.html
Icon={path_to_icon}
```
