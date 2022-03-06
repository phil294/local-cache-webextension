do =>
	url = new URLSearchParams(window.location.search).get('url') or 'url missing'
	{ [url]: { text, date, hits } } = await browser.storage.local.get(url)
	if not text
		return console.warn 'tried to display missing text in', url
	document.title = "Local Cache: #{url}"
	document.querySelector('#cached-text')?.textContent = text
	document.querySelector('#prompt')?.textContent = "Cached by Local Cache Extension #{hits} times, last on #{new Date(date).toLocaleString()}: #{url}"