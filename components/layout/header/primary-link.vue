<!--
Main nav links in the header
-->

<template lang='pug'>

nuxt-link.primary-link(:to='to')
	.label: slot
	.underline(v-if='active'): .pulse

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props:
		to: String

	computed:

		# Is this page active
		active: -> @$route.path.match @to

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.primary-link
	font rem(16px) gotham
	color black

	// So underline can be positioned
	position relative

	// moves label up for hover/active state
	+hover(true)
		.label
			opacity 0.6
			transform translateY(-2px)

.label
	transition transform 200ms ease-in-out-quint, opacity 300ms ease

// Active indicator
.underline
	position absolute
	rectangle 100%, 2px, blue
	bottom -8px
	overflow hidden

// Make the pulse shape
pulse-w = rem(35px)
.pulse
	position absolute
	rectangle pulse-w, 100%, dark-blue
	animation pulse 3s infinite ease-in-out-quint

@keyframes pulse
	from
		left pulse-w * -1
	50%
		left 100%
	to
		left 100%

</style>
