LUA_PATH="./lib/?.lua;;"

all: test

testsets:
	git submodule update --init

testfiles: testsets
	LUA_PATH=$(LUA_PATH) lua maint/testset_yaml2lua.lua
	sync; sync; sync;

checkyaml: testfiles
	perl woothee/bin/dataset_checker.pl

lib/resty/woothee/dataset.lua: checkyaml
	LUA_PATH=$(LUA_PATH) lua maint/dataset_yaml2lua.lua
	sync; sync; sync;

test: lib/resty/woothee/dataset.lua
	test -d t/testsets || mkdir t/testsets
	cp woothee/testsets/*.yaml t/testsets
	prove -Ilib
