APP_NAME = jyking99/neovim

dist:
	docker build -t $(APP_NAME):latest .

