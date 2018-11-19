# Get contentful's img util
{ img } = require 'bukwild-contentful-utils'

# Setup Vue visual
Vue.component('visual', require 'vue-visual').options.setDefaults

	# Default to bkgd color
	background: 'cover'

	# Loading defaults
	load: true
	loadPoster: true
	transition: 'vv-fade'

	# Video defaults
	muted: true
	loop: true
	autoplay: 'visible'

	# Handle Contentful media objects natively and geenrate a size equal to the
	# Visual.  Also creates posters automatically
	posterFromImage: true
	assetMutator: (asset, src, vm) ->
		posterSize = 4

		# Don't do any extra to video or string srcs
		return src if asset in ['video', 'fallback'] or typeof src == 'string'

		# Make a poster from the image
		if !src and asset == 'poster' and vm.posterFromImage and vm.image
			return img vm.image, posterSize, posterSize

		# If we don't know the size yet, ask for size and return a poster in the
		# meantime
		if vm.containerWidth == null and vm.containerHeight == null
			vm.watchSize = true
			return img src, posterSize, posterSize

		# We should know the dimensions at this point, so calculate the size
		w = calcSize vm, 'width'
		h = calcSize vm, 'height'
		return img src, w, h, format: 'jpg' if w or h

# Make a dimension given the vm
calcSize = (vm, side) ->

	# If not a background image and no size provided, return null
	return if vm.background not in ['cover', 'contain'] and not vm[side]

	# Settings
	interval = 200
	density = window?.devicePixelRatio || 1

	# Calculate the size, rounding it to the nearest interval
	ucSide = side.charAt(0).toUpperCase() + side.substr(1)
	containerSize = vm["container#{ucSide}"]
	size = density * interval * Math.ceil containerSize / interval

	# Apply % from width or height
	if perc = vm[side]?.match(/(^[\d\.])+%$/)?[1]
		size *= perc / 100

	# Return the final size
	return size
