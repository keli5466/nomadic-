{
	disableBodyScroll
	enableBodyScroll
	clearAllBodyScrollLocks
} = require 'body-scroll-lock'
export default

	data: -> open: false

	# Find the tab container
	mounted: -> @$nextTick -> @$nav = @$el.querySelector '.mobile-nav'

	# Cleanup
	destroyed: -> clearAllBodyScrollLocks()

	watch:

		# Close automatically on route change
		$route: -> @open = false

		# Turn body scroll on and off
		open: ->
			if @open
			then disableBodyScroll @$nav
			else enableBodyScroll @$nav
