APP_NAME = jyking99/neovim

local:
	ln -sf $(PWD)/src ~/.config/nvim

clean:
	rm -rf ./dist/

local-dist:
	mkdir -p ./dist/tmp/
	cp -r ~/.config/nvim/ ./dist/tmp/nvimConfig/
	cp -r ~/.local/share/nvim/ ./dist/tmp/nvimData/
	tar -czf ./dist/neovim.tar.gz ./dist/tmp/

dist:
	docker build -t $(APP_NAME):latest .

