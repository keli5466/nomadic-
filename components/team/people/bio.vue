<!--
The bio detail
-->

<template lang='pug'>

.bio
	.photo: visual(
		:image='person.image'
		:aspect='1')
	.copy.body-text.wysiwyg(v-html='$marked(person.bio)')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props: person: Object

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

break = tablet - 1px

.bio
	padding-left rem(80px) // Compensate for gap in grid
	padding-right rem(50px)
	padding-top rem(50px)
	padding-bottom rem(20px)

	// Columns
	display flex
	@media(max-width break)
		display block

.photo
	flex-shrink 0
	width (100%/3)
	padding-right rem(60px)
	@media(max-width break)
		width 100%
		padding-right 0
		margin-bottom 25px

.copy
	font-size rem(16px)
	align-self center
	color near-black
	@media(max-width break)
		font-size 14px

</style>
