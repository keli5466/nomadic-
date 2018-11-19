<!--

-->

<template lang='pug'>

footer: .max-w.large-mobile-gutter

	//- Main 3 columns
	.main-columns

		.primary-links
			nuxt-link(to='/about') what is nomadic
			nuxt-link(to='/experiences') our experiences
			nuxt-link(to='/faq') FAQs
			buy-tickets-btn.desktop(block @click='$store.set("showBuyDialog", true)')

		.secondary-links
			.col
				div: nuxt-link(to='/team') About Us
				div: nuxt-link(to='/contact') Partners
				div: a(href='https://nomadic.workable.com' target='_blank') Careers
				div: nuxt-link(to='/contact') Contact
			.col
				div: nuxt-link(to='/page/privacy') Privacy statement
				div: nuxt-link(to='/page/terms-of-service') Terms of service
				div: nuxt-link(to='/page/marketing-assets') Marketing assets

		//- Buy button moves here on mobile
		buy-tickets-btn.tablet(block @click='$store.set("showBuyDialog", true)')

		//- Newsletter signup column
		newsletter

	//- Smaller footer links
	.social-links
		.copyright  Nomadic © 2018
		.social
			a(href='https://www.facebook.com/nomadicVR' target='_blank')
				icon(name='facebook' height='1.5em')
			a(href='https://twitter.com/NomadicVr' target='_blank')
				icon(name='twitter' height='1.5em')
			a(href='https://www.instagram.com/nomadic_vr/' target='_blank')
				icon(name='instagram' height='1.5em')
			span.hash #blurtheline

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		newsletter: require './newsletter'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

@require '../../global/h3-unit/vars'

// Add backgroundd
footer
	background-image inverse-blue-gradient
	padding-top v-space
	padding-bottom v-space-mobile
	color white

	// Bigger top pad on mobile
	@media(max-width tablet - 1px)
		padding-top v-space - 1.5rem

// Match max-width of locations columns
.max-w
	width 100%
	@media(max-width three-col-break)
		max-width h3-unit-2-col-max-width
		margin-h auto

// Set default link styles
a
	color white
	transition opacity .3s ease-out-quint
	+hover(true)
		opacity 0.5

// Make the main columns, this is mostly eyeballed
.main-columns
	display flex
	justify-content space-between
	> *
		width h3-unit-width
		max-width h3-unit-max-width

	// Move newsletter onto it's own row
	@media(max-width three-col-break)
		flex-wrap wrap
		> *
			width 45%
		.newsletter
			margin-top v-space

	// Move secondary links into their own column
	@media(max-width tablet - 1px)
		display block
		> *
			width 100%
			margin-h auto
			max-width none
		.secondary-links
			margin-top v-space-mobile
			padding-h 0


// Main big links
.primary-links
	font 23px gotham
	line-height 2.43
	white-space nowrap

	// Make block links
	a
		display block
		border-bottom 1px solid rgba(white, 0.25)

// Buy button inside primary links
.buy-tickets-btn
	margin-top v-space-mobile

.secondary-links
	font rem(16px) gotham
	line-height 2.38
	white-space nowrap
	padding-h h3-unit-pad-h

	// Adjust the font size while shrinking
	@media(max-width tablet-landscape - 1px)
		font-size 15px, true
	@media(max-width tablet - 1px)
		font-size 16px, true

	// Align to primary links
	margin-top rem(18px) // Eyeballed

	// Make columns
	display flex
	.col:not(:first-child)
		margin-left rem(60px)

// Align to primary links
.newsletter
	margin-top rem(16px) // Eyeballed

// Bottom most links
.social-links
	font rem(17px) gotham
	margin-top v-space

	// Push extra far down
	@media(max-width tablet - 1px)
		margin-top v-space

	// Make columns
	display flex
	align-items center
	.social
		margin-left auto

		// Seperate links
		display flex
		align-items center
		> *:not(:first-child)
			margin-left rem(30px)

	// Reverse order on mobile
	@media(max-width tablet - 1px)
		font-size 14px
		flex-direction column-reverse
		align-items flex-start
		.copyright
			margin-top rem(40px) // Eyeballed
		.social
			margin-left 0
			width 100%
		.hash
			margin-left auto !important

</style>
