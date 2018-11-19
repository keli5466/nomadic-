# Scroll to anchors that are present in the page
VueScrollTo = require 'vue-scrollto'
Vue.use VueScrollTo

export default ({ app }) ->

	# If the path hasn't changed, scroll within the current page
	app.router.afterEach (to, from) ->
		if to.path == from.path
			if anchor = to.hash then VueScrollTo.scrollTo anchor
			else VueScrollTo.scrollTo 'body' # If no anchor, scroll to top

	# Scroll to anchors when the page changes
	document.addEventListener 'after-loader-leave', ->
		VueScrollTo.scrollTo anchor if anchor = app.router.currentRoute.hash
