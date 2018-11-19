<!--
Render slotted content with an h3 level header
-->

<template lang='pug'>

.marquee-headline(:class='{ vspace: subhead }')
	.content
		h1.headline1 {{ title }}
		.subhead(v-if='subhead' v-unorphan) {{subhead}}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
module.exports =

	props:
		title: String
		subhead: String

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.marquee-headline
	text-align center
	background-image inverse-blue-gradient
	color white
	padding-v rem(60px)
	@media (max-width tablet)
		padding-v 25px
		&.vspace
			padding-bottom 45px
			.subhead
				padding-bottom rem(10px)

// Contain and add shadow
.content
	position relative
	margin 0 5%
	display inline-block
	oval-shadow()

	// Scoot up shadow
	@media (max-width tablet)
		&:after
			bottom -1.5rem

// Shrink on tablet
.headline1
	@media (max-width tablet)
		font-size 26px, true

.subhead
	line-height 1.36
	max-width rem(574px)
	font-weight 300
	margin 0 auto
	font-size 21px
	padding-bottom rem(30px)
	margin-top rem(15px)



</style>
