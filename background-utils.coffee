globalThis.log = (###* @type {string} ### str) =>
	console.debug "ext: Local Cache: #{str}"

#
###* @return {Promise<{open_cache_when: "on_error" | "before_request" }>} ###
globalThis.get_options = =>
	{ options: { open_cache_when = "on_error" } = {} } = await browser.storage.local.get "options"
	{ open_cache_when }

globalThis.url_to_cache_landing_url = (###* @type {string} ### url) =>
	ext_version = browser.runtime.getManifest().version
	'local-cache-landing.html?' + new URLSearchParams({ url, ext_version }).toString()