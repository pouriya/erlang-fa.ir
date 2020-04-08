HUGO_RECOMMENDED_OPTS = --gc --verbose
HUGO_OPTS             =
DEST_DIR              = $(CURDIR)/erlang-fa.ir
WWW_DIR               = $(DEST_DIR)/www
BASE_URL              = https://erlang-fa.ir


.PHONY: build build-dev clean dist-clean serve serve-it ensure-dest-dirs


build:
	cd src && hugo -b $(BASE_URL) $(HUGO_RECOMMENDED_OPTS) --destination $(WWW_DIR) $(HUGO_OPTS)
	cat Caddyfile >> $(DEST_DIR)/Caddyfile
	cat Caddy.env >> $(DEST_DIR)/Caddy.env


build-dev:
	$(MAKE) build BASE_URL=http://localhost
	cp DevCaddyfile $(DEST_DIR)/Caddyfile


clean:
	rm -rf $(WWW_DIR)
	rm -rf $(TMP_DIR)


dist-clean: clean
	rm -rf $(DEST_DIR)
	rm -rf $(DEST_DIR)/Caddyfile


serve: build-dev serve-it


serve-it:
	export CADDY_ERLANG_ROOT_DIR=$(WWW_DIR) && caddy -root $(WWW_DIR) -conf $(DEST_DIR)/Caddyfile


ensure-dest-dirs:
	mkdir -p $(DEST_DIR)
	mkdir -p $(WWW_DIR)
