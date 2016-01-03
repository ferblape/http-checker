VERSION=0.1.0

all: build

.PHONY: spec
spec:
	crystal spec

build: http-checker

http-checker:  src/*.cr
	crystal build -o bin/http-checker --release src/cli.cr

clean:
	rm -rf .crystal bin/http-checker *.zip .deps libs
