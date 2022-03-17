do =>
	{ [window.location.href]: { hits = 0 } = { hits: 0 } } = await browser.storage.local.get window.location.href
	await browser.storage.local.set
		[window.location.href]:
			text: document.body.innerText.replaceAll(/\n[ \t]+$/mg, '\n').replaceAll(/\n{3,}/g, '\n').replaceAll(/[ \t]+$/mg, '').substr(0, 25000).trim()
			date: new Date().toISOString()
			hits: hits + 1