<!--
The modal window that is triggered by generic buy ticket links
-->

<template lang='pug'>

v-dialog(
	content-class='buy-tickets-dialog'
	v-model='show'): .buy-tickets(@click='onDialogClick')
	h2.title choose an experience

	//- Through through experiences wrapping them in shadow and and borders
	.experiences: experience(
		v-for='experience in experiences'
		:key='experience.id'
		:experience='experience')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { sync, get } from 'vuex-pathify'
export default

	components:
		'experience': require './experience'

	computed:

		# Sync up the show state
		show: sync 'showBuyDialog'

		# Get list of experiences
		experiences: get 'experiences/active'

	# Fore an update of in viewport when it opens
	watch: show: -> @$nextTick ->
		window?.dispatchEvent new CustomEvent 'scroll' if @show

	methods:

		# When dialog is clicked, fire a custom event to document with the event
		# target
		onDialogClick: (e) ->
			document.dispatchEvent new CustomEvent 'proxy-click',
				detail: target: e.target

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

@import './vars'

// The box
.buy-tickets
	display inline-block
	max-width 100%
	background white
	border-radius menu-border-radius

	// Add gutters
	@media(min-width pre-break)
		background white-gradient
		padding gutter
		padding-bottom gutter * 2


// Dialog title
.title
	font rem(30px) gothic
	text-align center
	@media(max-width break)
		text-align left
		padding mobile-gutter
		font-size rem(28px)

// Container of experiences
.experiences

	// Create columns
	@media(min-width pre-break)
		margin-top gutter * 0.9 // Looks a little better
		display flex
		> *
			display flex
			width rem(295px) // Works better than max-width in IE

			// Add spacing between experiences
			&:not(:first-child)
				margin-left rem(24px)

	// Create rows
	@media(max-width break)
		> *
			padding mobile-gutter
			border-top grey-border
			&:nth-child(even)
				background near-white

</style>

<style lang='stylus'>

// Center the dialog and support non-100% width
.buy-tickets-dialog
	text-align center
	width auto

</style>
