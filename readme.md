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

## Offline installation
**Prerequisite**: you have a working neovim installation that you want to copy to another machine

Step 1. Transfer `~/.local/share/nvim`
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

Step 2. Transfer `~/.config/nvim`
1. Copy this repository to the target machine
```bash
scp -r . user@target-machine:/path/to/destination
```
2. Follow steps 3 and 4 of [Setup locally](#setup-locally)

