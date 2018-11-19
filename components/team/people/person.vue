<!--
A person with a bio
-->

<template lang='pug'>

.person(
	:class='{ selected }'
	@click='onClick')
	.left
		h4.name {{ person.name }}
		.title {{ person.title }}
	.icon.icon-chevron-down

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props:
		person: Object
		selection: Object

	computed:

		# Is this selected?
		selected: -> @person.id == @selection?.id

	methods:

		# Fire selection events
		onClick: ->
			if @selected
			then @$emit 'update:selection', null
			else
				@$emit 'update:selection', null
				@$wait 350, => @$emit 'update:selection',  @person


</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.person
	button()
	background blue
	color white
	border-radius menu-border-radius
	padding rem(15px) rem(30px)

	// Make columns
	display flex
	align-items center

	// Add selected color
	transition background .3s
	&.selected
		background red

.name
	font rem(20px) gothic

.title
	font 14px gotham
	margin-top rem(5px)

.icon
	margin-left auto
	font-size 10px
	transition transform .3s
	.person.selected &
		transform rotate(180deg)

</style>
