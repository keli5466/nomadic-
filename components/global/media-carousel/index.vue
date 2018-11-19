<!--
The location carousel
-->

<template lang='pug'>

v-carousel.media-carousel(
	v-if='media && media.length > 0'
	v-in-viewport
	v-model='slide'
	delimiter-icon='icon-dot'
	prev-icon='icon-chevron-left'
	next-icon='icon-chevron-right'
	:cycle='false'
	:hide-controls='media.length <= 1'
	:hide-delimiters='media.length <= 1'
	:style='styles')
	slide(
		v-for='asset in media'
		:key='asset.sys.id'
		:asset='asset'
		:width='width'
		:height='height'
		:disable-scale-via-scroll='disableScaleViaScroll')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components: slide: require './slide'

	props:
		media: Array # Pass in an array of Contentful media
		aspect:
			type: Number
			default: 2880 / 992
		disableScaleViaScroll: Boolean

	data: -> slide: 0

	computed:

		# Make aspect ratio styes
		styles: -> 'padding-top': "#{100 / @aspect}%"

		# Calculate the 1x image size based on aspect
		width: -> 1920
		height: -> Math.round @width / @aspect

	# Recalcaulte layout when slide changes
	watch: slide:
		immediate: true
		handler: -> @$nextTick -> window?.dispatchEvent new CustomEvent 'resize'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Needed to show delimiters outside of the carousel
.media-carousel
	background black
	overflow visible
	@media (max-width tablet)
		min-height 250px

// delimiters / dots
>>> .v-carousel__controls
	background border-grey
	border-radius 13.5px
	width auto
	left 50%
	transform translateX(-50%)
	bottom delimi-height * -0.5
	padding-h 10px
	z-index 5
	height delimi-height
	@media (max-width mobile)
		background transparent
		bottom 'calc(-%s - 5px)' % delimi-height
		.v-btn
			color border-grey

</style>
