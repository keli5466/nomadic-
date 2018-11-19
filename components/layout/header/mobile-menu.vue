<!--
Main nav links in the header
-->

<template lang='pug'>
nav
	.mobile-nav
		.primary-links
			nuxt-link(to='/about') what is nomadic
			nuxt-link(to='/experiences') our experiences
			nuxt-link(to='/faq') FAQs
		.secondary-links
			nuxt-link(to='/team') About Us
			nuxt-link(to='/contact') Partners
			nuxt-link(to='/careers') Careers
			nuxt-link(to='/contact') Contact
			nuxt-link(to='/page/privacy') Privacy Statement
			nuxt-link(to='/page/terms-of-service') Terms of service
			nuxt-link(to='/page/marketing-assets') Marketing Assets
		buy-tickets-btn(@click='$store.set("showBuyDialog", true)')
		.social-links
			a(href='https://www.facebook.com/nomadicVR' target='_blank')
				icon(name='facebook' height='25')
			a(href='https://twitter.com/NomadicVr' target='_blank')
				icon(name='twitter' height='25')
			a(href='https://www.instagram.com/nomadic_vr/' target='_blank')
				icon(name='instagram' height='25')
			.hashtag #blurtheline
			.copyright Nomadic © 2017

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>


</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>
w = 400px

nav
	position absolute
	height 100vh
	width 100%
	left 0
	bottom 0
	top 0
	background-image linear-gradient(to top, #8ce5ff, #39b4e7 23%, #065f86)
	// VW to make 60px look good on any screen
	padding rem(25px) 14.5vw
	z-index 10
	// Needed for landscape mode on phones
	overflow-y auto

.mobile-nav
	display flex
	flex-direction column
	height 100%
	max-width w

// Flex margins & mobile button overides to match design
button
	min-height 50px !important
	margin-bottom auto

	>>>.icon
		height 25px!important
		width 38px !important
		margin-right 15px !important
// Flex margins
.primary-links
	margin-top auto

a
	color white

.secondary-links
.primary-links
button
	width 100%

.primary-links a
	font-size 24px, true
	line-height 2.29
	display block
	border-bottom 1px solid rgba(white, 0.25)

.secondary-links
	margin-v auto
	a
		display block
		line-height 2.06
		// Needed for screens < 375px
		@media (min-width 375px)
			font-size 16px, true


.social-links
	display flex
	flex-wrap wrap
	align-items center
	color white
	margin-top 1%
	line-height 1.65
	// Social icons
	div:nth-child(-n+3)
		margin-right rem(28px)
	.copyright
		font-size 12px, true
		width 100%
		margin-top 2%
		line-height 2.33
	.hashtag
		margin-left auto
		font-size 15px, true //Made smaller for mobile


// active
.icon
a
	opacity 1
	+hover(true)
		cursor pointer
		opacity 0.5
		transition opacity 100ms smooth-in-out

</style>
