clean:
	rm -rf ./dist/

local:
	ln -sf $(PWD) ~/.config/nvim

# For copying local nvim data to another machine
tarball:
	mkdir -p ./dist/
	tar -czf ./dist/nvim.tar.gz -C ~/.local/share/ nvim

