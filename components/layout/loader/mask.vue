<!--
The full screen mask
-->

<template lang='pug'>

transition: .mask(:class='theme' v-if='show')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default
	props: show: Boolean
	data: ->

		# Create themes array
		themes: ['red', 'blue']

		# The current theme to show
		theme: null

	# Show a random theme color
	watch: show:
		immediate: true
		handler: ->
			@theme = @themes[Math.floor(Math.random() * @themes.length)] if @show

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Make the mask bigger than the page so the in-back transition on leave has
// some extra space to work with
blue-src = url('./blue-mask.svg')
red-src = url('./red-mask.svg')
border-w = calc((200vh - 100vmin)/2)
border-h = calc((200vw - 100vmin)/2)
.mask

	// Fill page
	position absolute
	top -50vh
	left -50vw
	width 200vw
	height 200vh

	// Make the 9 slice
	border-image-slice 1
	border-image-repeat stretch
	border-style solid
	border-width border-w border-h

	// Style the image
	background-position center center
	background-size calc(100% + 10px) // Overflow to prevent subpixel issues

	// Blue mask variation
	&.blue
		border-image-source blue-src
		background-image blue-src

	// Orange mask variation
	&.red
		border-image-source red-src
		background-image red-src

	// Transition in
	&.v-enter-active
		animation scale-enter ease-out-expo 1s
		@keyframes scale-enter
			0%
				transform scale(8)
			100%
				transform scale(1)

	// Transition out
	&.v-leave-active
		animation scale-leave ease-in-out-quart .5s
		@keyframes scale-leave
			0%
				transform scale(1)
			50%
				transform scale(0.9)
			100%
				transform scale(8)

</style>
