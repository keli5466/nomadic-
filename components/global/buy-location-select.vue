<!--
A buy tickets btn that allows user to choose a location
-->

<template lang='pug'>

buy-tickets-btn(:block='block')

//- Disabled for launch
//- popper.buy-location-select(
//- 	ref='popper'
//- 	:class='classes'
//- 	:open.sync='open')
//-
//- 	//- The menu
//- 	.locations: v-btn.location(
//- 		v-for='location in experience.locations'
//- 		:key='location.id'
//- 		color='secondary'
//- 		depressed flat block :ripple='false'
//- 		:loading='clickedId == location.id'
//- 		@click='buy(location)')
//- 		.name {{ location.name }}
//- 		.city {{ location.city }}, {{ location.state }}
//-
//- 	//- Trigger the menu
//- 	buy-tickets-btn(
//- 		slot='activator'
//- 		:block='block'
//- 		:gradient='!open'
//- 		menu)

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props:
		experience: Object
		block: Boolean

	data: ->
		open: false
		clickedId: null

	computed:

		# Additional classes
		classes: ->
			block: @block
			open: @open

	# Sync global shade
	watch: open: ->
		@$store.set 'shade', @open unless @$store.get 'showBuyDialog'
		@$emit 'toggle', @open
		@$parent.$emit 'btnToggle', @open, @

	# Handle a location selection
	methods: buy: (location) ->
		if button = process.env.FORCE_BUTTON_ID || location.xolaButtonId
			xola.checkout { button }

		# Close after a tick, giving the Xola time to open
		@clickedId = location.id
		@$wait 1000, =>
			@$refs.popper.close()
			@clickedId  = null

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Support block styling
.buy-location-select.block
	display block

// Make the button fill the menu
.buy-tickets-btn
	width 100%

// When open, place it above the shade
.buy-location-select.open
	position relative
	z-index popper-z - 1

// Default typography
.locations
	color near-black
	text-align center
	line-height 1.1

// A location item
.location
	padding rem(35px)
	background white
	height auto
	&:nth-child(odd)
		background near-white
	&:not(:first-child)
		border-top 1px solid border-grey

	// Overlap the caret
	position relative
	z-index 2

	// Override flex
	>>> .v-btn__content
		display block

	// Make the hover use gradient so the triangle works better
	// transition background .4s
	&:before
		background-color inherit
		background-image dark-white-gradient
		opacity 0
	&:hover, &:active
		&:before
			opacity 0.5
	&:active
		&:before
			opacity 1

	// The triangle arrow shown at the bottom
	&:last-child
		menu-carret()

.name
	font 14px gotham
	color black

.city
	font medium 15px gotham
	color red
	margin-top rem(3px)

</style>
