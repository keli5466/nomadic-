<!--
Scale the slotted elemnt as the page scrolls
-->

<template lang='pug'>

.scale-via-scroll(:style='styles'): slot

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import parallax from 'scrollmonitor-parallax'

# Settings
maxScale = 1.5
minScale = 1.0
startRatio = 0
endRatio = 0.50

# Component
export default

	# Support disabling
	props: disable: Boolean

	data: ->
		maxScale: 1.5
		ratio: 1 # Default to finished
		distance: 0

	# Init and cleanup parallax-er
	mounted: -> @create() unless @disable
	destroyed: -> @destroy()

	computed:

		# Add styles to the component
		styles: -> transform: "scale(#{@scale})"

		# Calculate the scale from the ratio.
		scale: -> minScale + (maxScale - minScale) * @perc

		# Calculate percentage that should be applied to the tween
		perc: -> 1 - Math.max 0, Math.min 1, (@ratio / endRatio)

	methods:

		# Create the parallax instance
		create: ->
				@parallax = parallax.create @$el
				@parallax.add @$el, @onScroll

		# Force a recalculation
		recalculate: ->
			@parallax?.watcher?.recalculateLocation()

			# Double fake scroll events to get watcher to update
			window?.dispatchEvent new CustomEvent 'scroll'
			window?.dispatchEvent new CustomEvent 'scroll'

		# Store ratio and distance while scrolling
		onScroll: (@ratio, @distance) ->

		# Cleanup
		destroy: -> @parallax?.destroy()

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Make a mask that fills the container
.scale-via-scroll
	expand()
	overflow hidden

	// Disabling to make a better experience for trackpad users
	// transition transform 1s ease-out-quad

</style>
