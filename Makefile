GPG_PASSPHRASE_FILE:=~/.gpgpw
BUILD_DIR:=./dist

login:
	helm registry login https://ghcr.io

clean:
	@rm -rf $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)

ci: clean build publish
	helm repo index $(BUILD_DIR)

build:
	@find . -type f -name "Chart.yaml" | sed 's:/Chart.yaml::g' | sed 's:^./::g' | grep -v '_template' | xargs -L 1 -I{} make build-{}

publish:
	@find . -type f -name "*.tgz" | xargs -L 1 -I {} helm push {} oci://ghcr.io/agilesyndrome/nosecurity-charts

publish-%:
	@find . -type f -name "$*-*.tgz" | xargs -L 1 -I {} helm push {} oci://ghcr.io/agilesyndrome/nosecurity-charts

build-%:
	@helm package $* \
		-d $(BUILD_DIR) \
		--dependency-update \
		--keyring ~/.gnupg/charts.gpg \
		--passphrase-file $(GPG_PASSPHRASE_FILE)  \
		--key 'NoSecurity.dev' \
		--sign