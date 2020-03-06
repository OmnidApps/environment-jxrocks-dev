GO := GO111MODULE=off go

install-fmt-deps:
	$(GO) get github.com/abayer/fmt-yml-for-k8s

fmt: install-fmt-deps
	${GOPATH}/bin/fmt-yml-for-k8s --file jenkins-x.yml --output-dir .

verify-fmt: install-fmt-deps fmt
	$(eval CHANGED = $(shell git ls-files --modified --exclude-standard))
	@if [ "$(CHANGED)" == "" ]; \
		then \
			echo "jenkins-x.yml properly formatted"; \
		else \
			echo "jenkins-x.yml is not properly formatted"; \
			echo "$(CHANGED)"; \
			git diff; \
			exit 1; \
		fi

