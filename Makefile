LUA_PATH="./lib/?.lua;;"

all: test

testsets:
	git submodule update --init

testfiles: testsets
	LUA_PATH=$(LUA_PATH) lua maint/testset_yaml2lua.lua
	sync; sync; sync;

lib/resty/woothee/dataset.lua: testfiles
	LUA_PATH=$(LUA_PATH) lua maint/dataset_yaml2lua.lua
	sync; sync; sync;

test: lib/resty/woothee/dataset.lua
	prove -Ilib
