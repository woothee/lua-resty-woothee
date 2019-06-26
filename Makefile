LUA_PATH="./lib/?.lua;;"

all: test

local-all: docker-build docker-run-test

testsets:
	git submodule update --init

testfiles: testsets
	LUA_PATH=$(LUA_PATH) lua maint/testset_yaml2lua.lua
	sync; sync; sync;

lib/resty/woothee/dataset.lua: testfiles
	LUA_PATH=$(LUA_PATH) lua maint/dataset_yaml2lua.lua
	sync; sync; sync;

test: lib/resty/woothee/dataset.lua
	luacheck --codes lib
	prove -Ilib

docker-build: 
	docker build -t local/lua-resty-woothee .

docker-run-test: 
	docker run local/lua-resty-woothee sh -c 'make all'
