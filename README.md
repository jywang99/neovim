# Neovim configuration
This is my personal Neovim configuration that I use for personal and professional projects.\
I mainly use this to develop in: **Go, Java, C#, C++, Python, Svelte, React, Bash scripts**.

## Setup

### Setup locally
1. Download and install [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
2. Clone this repository
3. Create a symlink in Neovim's config directory (`~/.config/nvim/`) to the cloned repository
```bash
make local
```
4. Launch `nvim`
```bash
nvim
```
Dependencies will be automatically installed by Lazy.nvim

### launch.json

`launch.json` is supported for debugging using `nvim-dap` (see [dap documentation](https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt) for more info).

#### pytest example
```json
{
    "name": "Pytest integration",
    "type": "python",
    "request": "launch",
    "module": "pytest"
}
```

#### Java example
```json
{
    "name": "Launch",
    "type": "java",
    "request": "launch",
    "mainClass": "com.example.demo.DemoApplication",
    "args": "--spring.profiles.active=dev"
}
```

Full example:
```json
{
    "configurations": [
        {
            "name": "Pytest integration",
            "type": "python",
            "request": "launch",
            "module": "pytest",
            "args": ["-k", "example_test"]
        }
    ]
}
```

## Known issues

### jdtls (Java)

Sometimes after `git pull` or `git submodule update` in a java project and launching `nvim`, `jdtls` spams screen with errors. This is likely due to jdtls cache. \
It can be found here:
```
~/.cache/nvim/nvim-jdtls/
```
Try finding and deleting the cache directory for your project inside that directory, or delete the entire directory.

### Omnisharp (C#)

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

