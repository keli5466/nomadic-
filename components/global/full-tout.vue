<!--
A full width tout
-->

<template lang='pug'>

.full-tout(:class='classes')

	//- Headline as background bar
	h2.headline.mobile.headline4.max-w(v-if='headline')
		span(v-unorphan) {{ headline }}

	//- The background
	.image
		.aspect(:style='{ "padding-top": `${100 / aspect}%`}')
		scale-via-scroll
			visual.desktop(fill load='visible' :image='background')
			visual.mobile(fill load='visible' :image='mobileBackground || background')

	//- The copy components
	.content-wrap.max-w: .content.vp-scale-up(v-in-viewport.once)
		h2.headline.headline4(v-if='headline' v-unorphan) {{ headline }}
		.subhead(v-if='$slots.subhead'): slot(name='subhead')
		.body.body-text.wysiwyg(v-if='body' v-html='$marked(body)')
		.actions(v-if='to || popup')
			shadow-btn.vp-translate-y(v-in-viewport='{ top: -50 }')
				btn(
					v-if='to'
					primary wide
					nuxt :to='to') {{ cta }}
				btn(
					v-else-if='popup'
					primary wide
					@click='$store.set("showBuyComingSoonDialog", true)') {{ cta }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props:
		reverse: Boolean
		headline: String
		body: String
		popup: Boolean
		background: Object # A Contentful media ref
		mobileBackground: Object # A Contentful media ref
		aspect:
			type: Number
			default: 1400/720
		cta:
			type: String
			default: 'Learn more'
		to: String

	computed:

		# Add classes
		classes: -> reverse: @reverse

		# Calculate the 1x image size based on aspect
		width: -> 1920
		height: -> Math.round @width / @aspect
		posterWidth: -> Math.round @width * 0.1
		posterHeight: -> Math.round @height * 0.1

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

break = tablet - 1px

.full-tout
	position relative
	overflow hidden // For the scale-via-scroll

// Darken headers in body
.body >>>
	h2, h3
		font-size 30px
		text-transform lowercase
		color black
		margin-bottom 0.75em
		line-height 1.2

// Actions div
.actions
	margin-top 3em

// Desktop styling
@media(min-width break + 1px)

	// Setup aspect ratio
	.full-tout
		font-size 0
	.content-wrap
		font-size body-font-size
	.aspect, .content-wrap
		display inline-block
		vertical-align middle

	// Alternate the sides that the copy appears on
	text-align left
	.full-tout:nth-child(even) &
		text-align right

	// Reverse the direction
	.full-tout.reverse &
		text-align right
	.full-tout.reverse ~ .full-tout:nth-child(even) &
		text-align left

	// Fill bkgd
	.vv-visual, .image
		expand()

	// Swaps bkgd image
	.desktop
		display block

	.mobile
		display none

	// Add gutters around background
	.max-w
		padding-v max-w-gutter

	// Make box
	.content
		background white
		border-radius menu-border-radius
		padding rem(65px) rem(45px)
		max-width rem(475px)

		// Put above bkgd
		position relative

		// Default typography
		text-align left

	// Hide mobile headline
	.headline.mobile
		display none

	// Add a margin if there is subhead
	.subhead
		margin-top 1em

	// Push body off of headline
	.body:not(:first-child)
		margin-top 2em

// Mobile styling
@media(max-width break)

	// Back image relative to this container
	.image
		position relative
		overflow hidden // Needed to capture the scaling image

	// Swaps bkgd image
	.desktop
		display none

	// Style mobile header
	.headline
		background inverse-blue-gradient
		color white
		padding mobile-gutter
		padding-bottom mobile-gutter * 1.5 // So shadow is visible
		text-align center
		span
			oval-shadow()

	// Clear gutters
	.content-wrap
		padding 0

	// Container of copy
	.content
		background light-white-gradient
		padding-v mobile-gutter * 2
		padding-h mobile-gutter * 2

		// Have btn fill to gutters
		.btn
		>>>span
			width 100%
			max-width 318px


	// Clear interior headline
	.content .headline
		display none

	// Add a margin if there is subhead
	.subhead
		margin-bottom 2em

	// Center actions
	.actions
		text-align center

</style>
