document.querySelector("form")?.addEventListener "submit", (e) =>
	e.preventDefault()
	browser.storage.local.set
		options:
			open_cache_when: e.target?.elements.open_cache_when.value

document.addEventListener "DOMContentLoaded", =>
	{ open_cache_when } = await get_options()
	document.querySelector("#open_cache_when")?.value = open_cache_when