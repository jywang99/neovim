# Neovim configuration
This is my personal Neovim configuration that I use for personal and professional projects.\
I mainly use this to develop in
- Go
- Java
- C#
- C++
- Python
- Svelte
- React
- Bash scripts

## Setup locally
1. Download and install [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
2. Clone this repository
3. Create a symlink in Neovim's config directory to the cloned repository
```bash
make local
```
4. Launch `nvim`
```bash
nvim
```
Dependencies will be automatically installed by Lazy.nvim

### Nerdfont support
Make sure to install a [Nerdfont](https://www.nerdfonts.com/) for icons to display correctly.\
The terminal emulator of your choice must be set up to use the font.

## Offline installation
**Prerequisite**: you have a working neovim installation that you want to copy to another machine

**Step 1.** Transfer `~/.local/share/nvim`
1. Generate a tarball containing all Neovim config files and dependencies
```bash
make tarball
```
2. Copy the tarball to the target machine, and apply configs
On source machine:
```bash
scp ./dist/nvim.tar.gz user@target-machine:/path/to/destination
```
3. On target machine:
```bash
tar -xzf /path/to/destination/nvim.tar.gz -C ~/.config
```

**Step 2.** Transfer `~/.config/nvim`
1. Copy this repository to the target machine
```bash
scp -r . user@target-machine:/path/to/destination
```
2. Follow steps 3 and 4 of [Setup locally](#setup-locally)

## Known issues
### jdtls
Sometimes after `git pull` or `git submodule update` in a java project and launching `nvim`, `jdtls` spams screen with errors. If you know the project doesn't have any errors, this is likely due to cache. \
Cache can be found here:
```
~/.cache/nvim/nvim-jdtls/
```
Try finding and deleting the cache directory for your project in there, or delete the entire directory.

### Omnisharp
`omnisharp` can sometimes fail to start, resulting in the following error messages or similar:
```
Error executing luv callback:
/usr/share/nvim/runtime/lua/vim/lsp/rpc.lua:410: attempt to index local 'decoded' (a nil value)
stack traceback:
        /usr/share/nvim/runtime/lua/vim/lsp/rpc.lua:410: in function 'handle_body'
        /usr/share/nvim/runtime/lua/vim/lsp/rpc.lua:761: in function 'handle_body'
        /usr/share/nvim/runtime/lua/vim/lsp/rpc.lua:267: in function </usr/share/nvim/runtime/lua/vim/lsp/rpc.lua:251>
```
This sometimes resolves by itself after dismissing the error message, but if it doesn't, try restarting Neovim.

