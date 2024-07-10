## Setup locally
1. Download and install [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
2. Clone this repository
3. Create a symlink in Neovim's config directory to the cloned repository
```bash
make local
```
4. Open [packer.lua](src/lua/jy/packer.lua), and enter the following editor commands
```vim
:so
:PackerInstall
```
This will install all plugins used in the configuration

## Docker image
1. Pull docker image from here: https://hub.docker.com/repository/docker/jyking99/neovim/
2. Run the docker image and login with the following credentials:\
Default user: `dev` \
Default password: `devpass`
3. In the running docker container, run step 4 of [local setup](#setup)

## Offline installation
Prerequisite: you have a working neovim installation that you want to copy to another machine
1. Generate a tarball containing all Neovim config files and dependencies
```bash
make local-dist
```
2. Copy the tarball to the target machine
3. Extract the tarball to the target machine

**TODO** Re-organize tarball content, add instructions for target machine

