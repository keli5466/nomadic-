<!--
Render an address inside an h3
-->

<template lang='pug'>

h3-unit.address(title='Address')

	//- Address and phone
	.content
		.address(v-html='$marked(location.address)')
		.phone: a(:href="'tel:'+ location.phone") {{ location.phone }}

	//- Submit button
	btn(
		grey block
		icon='pin' iconColor='#2fb3e9'
		:href="'http://maps.google.com/?q=/'+ location.address"
		target='blank') Get Directions

	//- Allow appending after the address info
	slot

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components: 'h3-unit': require '~/components/global/h3-unit'

	props: location: Object

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

afterbreak()
	@media(max-width tablet - 1px)
		{ block }
	&.break-at-three-col, .address.break-at-three-col &
		@media(max-width three-col-break)
			{ block }

// On mobile, remove the h3-unit chrome
.h3-unit.address // Increase specifity
	+afterbreak()
		border none
		padding 0
		margin-h auto
		margin-top 0
		>>> h3
			display none

// Indent contnet
.content
	padding-left rem(15px) // The gutter on the box
	text-align left
	+afterbreak()
		text-align center
		padding-left 0

// Make space above buttons
.btn
	margin-top rem(30px)

</style>
