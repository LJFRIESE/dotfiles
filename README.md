# Notes

Assumes Ubuntu (WSL) and Windows 10

## Home structure

~/.config
~/git
 - All cloned repos go here

# FZF

Search syntax
Unless otherwise specified, fzf starts in "extended-search mode" where you can type in multiple search terms delimited by spaces. e.g. ^music .mp3$ sbtrkt !fire

|Token |	Match type | Description|
|____________________________________|
|sbtrkt |	fuzzy-match	 | Items that match sbtrkt|
|'wild	|exact-match (quoted) | 	Items that include wild|
|'wild'	|exact-boundary-match (quoted both ends) | 	Items that include wild at word boundaries|
|^music	|prefix-exact-match	 | Items that start with music|
|.mp3$	|suffix-exact-match	 | Items that end with .mp3|
|!fire	|inverse-exact-match | 	Items that do not include fire|
|!^music	|inverse-prefix-exact-match	 | Items that do not start with music|
|!.mp3$	|inverse-suffix-exact-match	 | Items that do not end with .mp3|
