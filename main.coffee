open_cache_if_exist = (###* @type {string} ### url) =>
	tabs = await browser.tabs.query {}
	landing_url = url_to_cache_landing_url url
	cache_hit = !!(await browser.storage.local.get(url))[url]
	log "cache hit for '#{url}': #{cache_hit}"
	if cache_hit
		if not tabs.some (tab) => tab.url?.endsWith landing_url
			await browser.tabs.create
				url: landing_url

#
###* @param {{ url: string }}_ ###
before_request = ({ url }) =>
	log "before_request '#{url}'"
	do =>
		if (await get_options()).open_cache_when == "before_request"
			open_cache_if_exist url
	return

#
###* @param {{ error?: string, url: string, statusCode?: number, tabId: number }}_ ###
after_request = ({ error, url, statusCode, tabId }) =>
	log "after_request '#{url}', status #{statusCode}, error #{error}"
	tabs = await browser.tabs.query {}
	landing_url = url_to_cache_landing_url url
	if error or (statusCode or 999) > 399
		if (await get_options()).open_cache_when == "on_error"
			open_cache_if_exist url
	else
		if cache_tab = tabs.find (tab) => tab.url?.endsWith landing_url
			browser.tabs.remove(cache_tab.id or -1)
		browser.tabs.executeScript tabId, file: 'google-stinks/browser-polyfill.min.js'
		await browser.tabs.executeScript tabId, file: 'inject.js'

#
###* @type {import('webextension-polyfill').WebRequest.RequestFilter} ###
filter =
	urls: ["https://*/*", "http://*/*"]
	types: ["main_frame"]

browser.webRequest.onBeforeRequest.addListener before_request, filter
browser.webRequest.onCompleted.addListener after_request, filter
browser.webRequest.onErrorOccurred.addListener after_request, filter

console.log 'ext: Local Cache: init', new Date