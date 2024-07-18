APP_NAME = jyking99/neovim

local:
	ln -sf $(PWD)/src ~/.config/nvim

clean:
	rm -rf ./dist/

# For copying local nvim data to another machine
tarball:
	mkdir -p ./dist/
	tar -czf ./dist/nvim.tar.gz -C ~/.local/share/ nvim

dist:
	docker build -t $(APP_NAME):latest .

