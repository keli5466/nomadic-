<!--
Quotes caoursel
-->

<template lang='pug'>

v-carousel.quotes-carousel.max-w(
	v-if='quotes.length > 0'
	v-in-viewport
	v-model='slide'
	delimiter-icon='icon-dot'
	prev-icon='icon-chevron-left'
	next-icon='icon-chevron-right'
	:cycle='false'
	:hide-controls='quotes.length <= 1'
	:hide-delimiters='quotes.length <= 1')
	v-carousel-item.quote(
		v-for='quote in quotes'
		:key='quote.id')
		scale-via-scroll(ref='scalers')
			visual(
				fill
				:class='{ desktop : quote.mobileBackground }'
				:poster='$contentful.img(quote.background, 4, 4, { format: "jpg" })'
				:image='$contentful.img(quote.background, 2880, 992, { format: "jpg" })')
			visual.tablet(
				fill
				v-if='quote.mobileBackground'
				:poster='$contentful.img(quote.mobileBackground , 4, 4, { format: "jpg" })'
				:image='$contentful.img(quote.mobileBackground , 2880, 992, { format: "jpg" })')

		.content
			blockquote.headline2(v-unorphan) {{ quote.quote }}
			visual.logo(
				:image='$contentful.img(quote.logo, 230, 150)'
				background='')
			.actions(v-if='quote.url')
				btn(wide :href='quote.url') Read More

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import scrollmonitor from 'scrollmonitor'
export default

	props: quotes: Array

	data: -> slide: 0

	watch:

		# Re-calc slides as they are shown
		slide: -> @$nextTick -> @$refs.scalers[@slide]?.recalculate()

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Give it an aspect ratio ... this carousel does not work with flexible heights
.quotes-carousel
	overflow hidden
	aspect-ratio (1400 / 600)
	padding-v 10px
	@media (max-width tablet-landscape)
		aspect-ratio (1)
		min-height 400px

// Center the contents
>>> .v-responsive__content
	display flex
	height 100%
	align-items center

// Container of text
.content
	position relative
	max-width rem(600px) //we should reserve the line break in CMS instead
	margin-left 'calc(%s * 2)' % max-w-gutter
	text-align left
	color white
	@media (max-width tablet)
		text-align center
		margin-h auto

	// Fade in viewport
	transition opacity .4s
	.quotes-carousel:not(.in-viewport) &
		opacity 0

	// Also fade in as part of the carousel transition
	// Override transition
	.tab-reverse-transition-enter-active, &
	.tab-transition-enter-active &
		transition-delay .4s
	.tab-reverse-transition-enter &, .tab-transition-leave-to &,
	.tab-reverse-transition-leave-to &, .tab-transition-enter &
		opacity 0

.logo
	margin-top 2% //EB acts as buffer
	margin-bottom rem(40px)
	max-width rem(115px)

// Deep Roots, vue viusual & carousel
>>>
	// Black image overlay
	.vv-image
		&:after
			content ''
			background-color rgba(22, 22, 22, 0.45)
			center()
			width 100%
			height 100%

	// delimiters
	.v-carousel__controls
		background transparent

	.vv-slot
		width 100%

// Add some gutters after the break
blockquote
	@media(max-width tablet)
		padding-h mobile-gutter

</style>
