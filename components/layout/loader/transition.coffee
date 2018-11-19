# Wait to switch pages until the loader is ready
module.exports =
	css: false

	# Load pages simultaneously so we start loading assets on new page as soon
	# as possible while keeping it's visibility hidden
	mode: ''

	# Keep the old page until promise is finished
	leave: (el, done) ->
		await @$store.get 'loader/complete'
		done()

	# Hide the new page until we're ready
	enter: (el, done) ->
		el.style = 'opacity: 0; position: absolute;'
		await @$store.get 'loader/complete'
		el.style = ''
		done()

		# Trigger recalculating of sizes, like by Vue-visual.  This fixes issues
		# where the auto-calculated size was wrong and images were being reqquested
		# too small
		setTimeout (-> window?.dispatchEvent new CustomEvent 'resize'), 0
