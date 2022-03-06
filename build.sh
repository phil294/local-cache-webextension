#!/bin/bash
set -e

yarn
yarn coffee -c *.coffee
rm -rf dist google-stinks
mkdir google-stinks && cp node_modules/webextension-polyfill/dist/browser-polyfill.min.js google-stinks/
mkdir dist
cp -r manifest.json icons *.js *.html google-stinks dist