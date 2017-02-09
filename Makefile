all: build

build:
	@docker build --tag=purewind/hadoop:latest .

release: build
	@docker build --tag=purewind/hadoop:$(shell cat VERSION) .