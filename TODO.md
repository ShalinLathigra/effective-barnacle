# Arch Linux Ricing


## Configuration

### Kitty

- [x] Colour, style

### Nvim

- [x] Lazy.nvim
- [x] lua51
- [x] luaJIT
- [x] LSP (C/C++ via clangd first)
- [x] LSP (Markdown)
- [x] leap.nvim
- [x] indent
- [ ] nvim-cmp
- [ ] nvim-lint
- [x] mason.nvim
- [x] plenary
- [x] telescope
    - Configure <leader> key, need to figure out what this currently is and how to
        adjust it
- [x] ripgrep
- [ ] auto-session
- [x] Relative Line Numbers
- [x] Tab use Spaces

### Niri

- [ ] Default Workspace windows?
- [ ] Make one that's just for fun, possibly include that process scanner!

## Additional Reading

- [ ] https://www.reddit.com/r/linux4noobs/comments/ejsz3v/still_on_windows_7_dont_want_windows_10_consider/
- [ ] github.com/chubin/awesome-console-services

## Make my own

[[/usr/local/src/tools/README.md]]

- [x] Wallpaper cycler
- [x] Linux File Manager + Navigator
- [x] Password Manager
- [ ] something within  https://www.reddit.com/r/linux4noobs/comments/ejsz3v/still_on_windows_7_dont_want_windows_10_consider/
- [ ] and something with awesome-console-services (chubin)
- [ ] lolcat
- [ ] cowsay
- [ ] fortune
- [ ] cbonsai
- [ ] Theme/prompt. I can probably pull something similar ish to powerlevel10k, though probably not as good. That's kinda fine though, just seems like a cool/fun thing to do

- [] Read up on dms, what sort of scripting can I do

## Install

### Password Management

- [x] KeePass equivalent, port over pwds
- [x] mpv (media player?)
- [x] eza to test out vs ls
    - github.com/eza-community/eza
        - Configured, now it's at e, ea, el, ela, elt
        - [[ -f /usr/local/share/merlin.conf ]] && . /usr/local/src/merlin.conf

### Shell/Theme/Prompt

- [x] Decide between zsh, fish
- [x] Decide between powerlevel10k and starship

### Backgrounds

- [x] metgallery hokusai

### File Manager

- [x] fff
    - [x] Requires additonal config in .bashrc or .fish when I settle on a thing
- [x] yazi

### Web

- [x] Firefox
- [x] lynx
- [x] edbrowse (hopefully for scripting)
    - [ ] Needs config in ~/.ebrc

### Performance

- [x] btm (detailed resource manager)
- [x] zfxtop (pretty resource manager)
- [x] px (ps with spice, bottom loaded)
    - ptop (top with more info, also per user)
    - pxtree (whole process tree, can use a pid)

### Fun

- [x] fastfetch
    - [x] pacman package not found
- [x] howdoi
    - [ ] Needs extra config, browser not supported...

## Style

- [x] Transparent terminals
- [x] Find a neat backdrop, maybe just a solid colour or pattern
- [x] Terminal rounding config
- [x] systemctl timer automatic backdrop cycling (/etc/systemd/user/sl-theme.*)

## Keyboard

- [x] Swap Caps + Backspace

## Start Up

- [x] Default NetworkManager on
- [x] Fetch computer stats
- [x] Use wttr (add script to bash!, also :help)

