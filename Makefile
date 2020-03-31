HUGO_RECOMMENDED_OPTS = --gc --verbose
HUGO_OPTS             =
DEST_DIR              = $(CURDIR)/www
BASE_URL              = https://erlang-fa.ir


.PHONY: build fa en build-dev clean serve serve-it clean-fa clean-en ensure-dest-dir


build:
	cd src && hugo -b $(BASE_URL) $(HUGO_RECOMMENDED_OPTS) --destination $(DEST_DIR) $(HUGO_OPTS)

build-dev:
	$(MAKE) build BASE_URL=http://localhost


clean:
	@echo Cleaning destination directory
	rm -rf $(DEST_DIR)


serve: build-dev serve-it


serve-it:
	export DEST_DIR=$(DEST_DIR) && caddy -root $(DEST_DIR) -conf DevCaddyfile


ensure-dest-dir:
	mkdir -p $(DEST_DIR)

