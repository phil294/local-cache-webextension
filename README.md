## Firefox
You can install this as a Firefox addon [here](https://addons.mozilla.org/en-US/firefox/addon/local-cache/).

### Command line
To process the Firefox database from command line (outside FF), try [moz-idb-edit](https://gitlab.com/ntninja/moz-idb-edit): You need to [figure out `EXT_ID` and `MOZ_PROFILE`](https://stackoverflow.com/a/59923297/3779853) and the exact `URL`, then it's

    ./moz-idb-edit -x "${EXT_ID}" --profile "${MOZ_PROFILE}" |sponge | tail +2 |jq ".'${URL}'.text"
    
In here, I'm using `sponge` from moreutils because piping doesn't work otherwise, and `tail +2` to skip the first comment line, and `jq` to parse the JSON output as `moz-idb-edit` can't handle more complicated keys such as urls.

## Chrome
Not available on Chrome store, but it is compatible if you install it manually.

## Build
To build this extension, run `./build.sh` on any unix-like system. Requires `yarn` to be installed, but `npm` can be used too. No specific versions required, but most recently built with `npm 8.4.1` and `node v16.14.0`. The resulting extension will be placed inside `/dist`.

Source hosted on [GitHub](https://github.com/phil294/local-cache-webextension)

## Alternatives

- [Falcon](https://github.com/lengstrom/falcon). Falcon is awesome and somewhat popular on Chrome. There is a Firefox fork too. Notable differences to Local Cache: [Supports full text search](https://github.com/lengstrom/falcon/issues/78#issuecomment-1069166388), but does not offer opening the cached version: If the site is not available for whatever reason, the extension does not help you afaik (although it *could*). Also does not understand HTTP codes, so if a site turns into 404 one day, the old cached content is gone
