<!--
The address and other info for a location
-->

<template lang='pug'>

.location-info.max-w

	//- Adddress col
	address-unit.third(:location='location')

		//- Buy button shown after break
		shadow-btn(block)
			buy-tickets-btn(block @click='$store.set("showBuyDialog", true)')

	//- Hours column
	h3-unit.third(title='Hours')
		.hours(v-html='$marked(location.hours)')

	//- Experience col
	h3-unit.third.experience-col(title='experience')
		.experience(v-html='$marked(location.buySubhead)')
		shadow-btn(block)
			buy-tickets-btn(block @click='$store.set("showBuyDialog", true)')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		'h3-unit': require '~/components/global/h3-unit'
		'address-unit': require '~/components/global/h3-unit/address'

	props: location: Object


</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

@import '../h3-unit/vars'

.location-info
	display flex
	justify-content space-between
	flex-wrap wrap

	// Break to 2 column
	@media(max-width three-col-break)
		max-width h3-unit-2-col-max-width
		padding-h mobile-gutter * 2
		text-align center

// Show buy button after break
.address .shadow-btn
	margin-top rem(10px)
	@media(min-width three-col-break + 1px)
		display none !important

// The experienc column
.experience-col
	text-align center

	// Make space above button
	.btn
		margin-top rem(30px)

	// Hide experience col at break
	@media(max-width three-col-break)
		display none

// Style the hours table
.hours >>>

	// Center the table but align text left
	table
		text-align left
		width 100%

	// Add vertical padding
	td
		padding-v rem(5px)

		// The label
		&:first-child
			font-weight 500
			white-space nowrap
			padding-right rem(25px)

		// The hours
		&:last-child
			font-weight 300

</style>
