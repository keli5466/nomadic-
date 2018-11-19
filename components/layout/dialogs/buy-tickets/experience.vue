<!--
An experience card within the global buy-tickets window
-->

<template lang='pug'>

.shadow(:class='{ open: open }'): .border

	//- Shade
	v-fade-transition: .shade(v-show='open')

	//- Vertical experience card
	experience(
		no-age no-status no-features no-learn-more no-shadow-btns
		:experience='experience'
		@buyToggle='open = $event')

	//- Add a buy button that is only shown on mobile
	buy-location-select.mobile-buy(
		:experience='experience'
		block)

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props:
		experience: Object

	data: -> open: false

	components:
		'buy-location-select': require '~/components/global/buy-location-select'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

@import './vars'

// Apply shadow
@media(min-width pre-break)
	.shadow
		oval-shadow()

// Apply border
@media(min-width pre-break)
	.border
		border grey-border
		border-radius 5px
		overflow hidden

// Shade shown when button open
.shade
	expand rgba(#212121, .46) // Matches v-overlay
	z-index 1

// The single experience
.buy-tickets-dialog .experience.vertical // Increase specifity
	height 100%

	// Different split on mobile
	@media(max-width break)
		flex-direction row
		>>> .experience-poster
			width 40% // Rdeuce size
			border-radius menu-border-radius
			overflow hidden
		>>> .copy
			width 60%
			background none
			padding-right 0 // Prevent doubling of padding
		>>> .actions
			display none
		>>> .logo
			width 80%

// The mobile buy button
.mobile-buy
	margin-top mobile-gutter * 0.5

	// Hide on desktop
	@media(min-width pre-break)
		display none !important

</style>
