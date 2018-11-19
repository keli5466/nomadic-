<!--
Render slotted content with an h3 level header
-->

<template lang='pug'>

.h3-unit
	h3 {{ title }}
	slot

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
module.exports =

	props: title: String

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

@import './vars'
headline-height = rem(20px)

.h3-unit
	position relative
	border-top grey-border
	border-bottom grey-border
	padding rem(40px) h3-unit-pad-h
	line-height 1.75

	// Reset font size on mobile
	font-size 16px
	@media(max-width tablet - 1px)
		font-size 15px, true
		padding-h 0

	// Add default 1/3 column style
	&.third
		width h3-unit-width
		max-width h3-unit-max-width
		@media(max-width three-col-break)
			width 45%
		@media (max-width tablet - 1px)
			width 100%
			margin-top v-space
			max-width 400px
			margin-h auto

h3
	font 22px 'all-round-gothic'
	text-transform lowercase
	background white
	line-height headline-height
	display inline-block
	text-align center
	white-space nowrap
	padding 0 18px
	left 50%
	transform translateX(-50%)
	position absolute
	top 'calc(-%s /2)' % headline-height

</style>
