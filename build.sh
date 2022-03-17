#!/bin/bash
set -e

yarn coffee -c *.coffee
yarn
rm -rf dist* google-stinks
mkdir google-stinks && cp node_modules/webextension-polyfill/dist/browser-polyfill.min.js google-stinks/
mkdir dist
cp -r manifest.json icons *.js *.html google-stinks dist

# for FF AMO
pushd dist
zip -r dist.zip -- *
popd
git clone --depth=1 --branch=main . dist_src
rm -rf ./dist_src/{.git,demo,icons,LICENSE}
cd dist_src
zip -r dist_src.zip -- *