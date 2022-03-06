#!/bin/bash
set -e

yarn
yarn coffee -c -w *.coffee &
cp node_modules/webextension-polyfill/dist/browser-polyfill.min.js google-stinks