<!--
The experience detail marquee
-->

<template lang='pug'>

section.marquee

	//- The background carousel
	media-carousel(
		disable-scale-via-scroll
		:media='experience.marquee'
		:aspect='1440/720')

	//- Copy block
	.max-w.content-wrap: .content.vp-translate-y(v-in-viewport.once)

		//- Logo, buy link, etc
		.branding
			logo(:experience='experience')
			recommended-age(:experience='experience')
			shadow-btn.desktop-buy(block)
				buy-location-select(:experience='experience' block)

		//- The descripion
		.description.body-text.wysiwyg(v-html='$marked(experience.description)')

		//- Mobile buy button
		shadow-btn.mobile-buy(block)
			buy-location-select(:experience='experience' block)

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		'buy-location-select': require '~/components/global/buy-location-select'
		'media-carousel': require '~/components/global/media-carousel'
		'recommended-age': require 'library/components/experience/card/recommended-age'
		'logo': require 'library/components/experience/card/logo'

	props: experience: Object

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Vars
h-gutter = rem(80px)
content-offset = rem(-80px)
mobile-content-offset = 0
break = tablet - 1px

// Recenter elements of the marquee
.media-carousel >>>

	// Get back/next centered
	.v-carousel__prev, .v-carousel__next
		margin-top content-offset * 0.5

	// Position the dots
	.v-carousel__controls
		bottom content-offset * -1
		transform translate(-50%, 50%)

		// Restyle it
		background red
		.v-carousel__controls__item--active .v-icon
			color dark-red
	@media(max-width break)
		.v-carousel__prev, .v-carousel__next
			margin-top mobile-content-offset * 0.5
		.v-carousel__controls
			bottom mobile-content-offset * -1

// Apply the orange background under the marquee
.content-wrap
	background linear-gradient(to top, #ff6635, #ea4915 50%, #d03706)
	padding-bottom max-w-gutter
	@media(max-width break)
		padding-v mobile-gutter
// Container of loog and description
.content
	background light-white-gradient
	padding rem(65px) h-gutter
	border-radius menu-border-radius

	// Overlap the carousel
	margin-top content-offset
	position relative

	// Create columns
	display flex
	> *
		width 50%

	// Stack columns
	@media(max-width break)
		display block
		margin-top mobile-content-offset
		padding mobile-gutter
		> *
			width auto

// Branding column has some extra padding
.branding
	padding-left rem(20px)
	padding-right h-gutter + @padding-left

	// Remove extra padding
	@media(max-width tablet-landscape)
		padding-left 0
		padding-right h-gutter

	// Stack
	@media(max-width break)
		padding-right 0

// Reduce logo size on mobile
.logo
	@media(max-width break)
		max-width 200px

.recommended-age
	margin-top rem(30px)
	&.break
		@media(max-width break)
			padding-h mobile-gutter

// Push  buy button down
.branding .desktop-buy
	margin-top rem(30px)

	// Switch to button that comes after the end
	@media(max-width break)
		display none !important

// Push down a bit so logo is higher
.description
	padding-top rem(30px)

	// Header style
	>>> h2
		font-size rem(30px)
		color black
		line-height 1.2

	// Restore font size
	@media(max-width break)
		margin-top 10px
		padding-h mobile-gutter // Indent

// Buy button on mobile
.mobile-buy
	@media(min-width break + 1px)
		display none !important
	margin-h mobile-gutter
	margin-top mobile-gutter
	margin-bottom 10px // A little extra looks better

</style>
