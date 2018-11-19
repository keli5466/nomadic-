<!--
A little headline used on sub pages
-->

<template lang='pug'>

.mobile-headline.tablet {{ title }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props:
		title: String

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.mobile-headline
	border-top solid 1px #f0f0f0
	padding-v 10px
	font 14px gotham
	color black
	text-align center

</style>
