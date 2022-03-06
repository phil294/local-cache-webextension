#
###* @param {{ error?: string, url: string, statusCode?: number, tabId: number }}_ ###
request_listener = ({ error, url, statusCode, tabId }) =>
	tabs = await browser.tabs.query {}
	landing_url = 'local-cache-landing.html?' + new URLSearchParams({ url }).toString()
	if error or (statusCode?.toString()[0] or 0) > 3
		console.debug 'ext: Local Cache', error, statusCode
		if ['NS_BINDING_CANCELLED_OLD_LOAD', 'NS_BINDING_ABORTED', 'net::ERR_ABORTED'].includes(error or '')
			# e.g. when spamming F5. These error codes are FF, FF, Chrome. TODO: Safari
			return
		cache_hit = !!(await browser.storage.local.get(url))[url]
		if cache_hit
			if not tabs.some (tab) => tab.url?.endsWith landing_url
				await browser.tabs.create
					url: landing_url
	else
		browser.tabs.executeScript tabId, file: 'google-stinks/browser-polyfill.min.js'
		await browser.tabs.executeScript tabId, file: 'inject.js'

#
###* @type {import('webextension-polyfill').WebRequest.RequestFilter} ###
filter =
	urls: ["https://*/*", "http://*/*"]
	types: ["main_frame"]

browser.webRequest.onCompleted.addListener request_listener, filter
browser.webRequest.onErrorOccurred.addListener request_listener, filter

console.log 'ext local-cache: init', new Date