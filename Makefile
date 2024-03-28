GPG_PASSPHRASE_FILE:=~/.gpgpw

login:
	helm registry login https://ghcr.io

clean:
	@rm -rf ./dist
	@mkdir -p ./dist

ci: clean build publish
	helm repo index dist
	@cp dist/index.yaml docs/index.yaml
	@git add docs/index.yaml
	git commit -S -m 'updated index.yaml'
	git push

build:
	@find . -type f -name "Chart.yaml" | sed 's:/Chart.yaml::g' | sed 's:^./::g' | grep -v '_template' | xargs -L 1 -I{} make build-{}

publish:
	@find . -type f -name "*.tgz" | xargs -L 1 -I {} helm push {} oci://ghcr.io/agilesyndrome/nosecurity-charts

publish-%:
	@find . -type f -name "$*-*.tgz" | xargs -L 1 -I {} helm push {} oci://ghcr.io/agilesyndrome/nosecurity-charts

build-%:
	@helm package $* \
		-d dist \
		--dependency-update \
		--keyring ~/.gnupg/charts.gpg \
		--passphrase-file $(GPG_PASSPHRASE_FILE)  \
		--key 'NoSecurity.dev' \
		--sign