APP_NAME = jyking99/neovim

local:
	cp -r ./src/* ~/.config/nvim/

dist:
	docker build -t $(APP_NAME):latest .

