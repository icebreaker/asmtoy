build:
	mkdir -p docs
	cp dosbox/dosbox.ico docs/favicon.ico
	cp dosbox/dosbox.js docs
	cp dosbox/dosbox.html.mem docs
	dosbox/packager.py docs/index asmtoy ASMTOY.BAT

clean:
	rm -rf docs

server:
	cd docs && python -m SimpleHTTPServer || exit 0

.PHONY: build clean server
