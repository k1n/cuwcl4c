@echo off
pushd %~dp0
if not exist obj mkdir obj

echo Concat rules to include..
node compile.js -out=src/Rules.ts "-code=<%% #build-rules.ts %%>"

echo Compile Loader..
call tsc --out obj/loader.js src/loader/Loader.ts

echo Compile main module..
call tsc --out obj/stage1.js src/EntryPoint.ts --module AMD

echo Compile meta..
node compile.js -out=obj/meta.js -input=src/meta.js

echo Join output..
copy /b obj\meta.js+obj\loader.js+obj\stage1.js out\script.js /y

