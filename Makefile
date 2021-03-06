BUILD_DIR = .build
REPO_NAME = github.com/honsiorovskyi/nginx_config_updater
BIN_PATH = $(BUILD_DIR)/$(REPO_NAME)
SOURCES = \
		  config.go \
		  http.go \
		  updater.go

VERSION=$(or $(TRAVIS_TAG), $(shell git describe --tags $(shell git rev-list --tags --max-count=1)))
BUILD_NUMBER=$(or $(TRAVIS_BUILD_NUMBER), 0)
COMMIT=$(shell git rev-parse --short HEAD)
GO_VERSION:=$(shell go version | awk '{ print $$3"-"$$4 }')

.PHONY : clean

$(BIN_PATH) : $(SOURCES)
	CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags "-w -X main.Version=$(VERSION)-build$(BUILD_NUMBER)-$(COMMIT)-$(GO_VERSION)" -o $(BIN_PATH) .

clean :
	rm -rf $(BUILD_DIR)
