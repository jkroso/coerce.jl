
dependencies: dependencies.json
	@packin install --folder $@ --meta $<
	@ln -sf .. $@/coerce

test: dependencies
	@$</jest/bin/jest test

.PHONY: test