SHELLCHECK_VERSION := v0.9.0
SH_FILES := $(shell find ./ -type f -name \*.sh)

.PHONY: fmt
fmt:
	@shfmt -i 4 -l -w -sr -kp -f .

.PHONY: lint
lint:
	shellcheck --severity=error ${SH_FILES}

.PHONY: setup
setup:
	@wget -qO- "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz" | tar -xJv
	@sudo cp "shellcheck-${SHELLCHECK_VERSION}/shellcheck" /usr/local/bin/
	@rm -rf "shellcheck-${SHELLCHECK_VERSION}/"
	shellcheck --version
