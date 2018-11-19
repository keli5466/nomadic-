<!--
Dream team component
-->

<template lang='pug'>

.dream-team

	//- Intro
	.marquee
		img(src='~/assets/imgs/bug.svg' style='height: 32px')
		h2.headline.headline2 {{ page.teamHeadline }}
		visual.image(
			:image='page.teamImage'
			width='100%'
			background=''
			:poster-from-image='false')

	.inner-gutter.description {{ page.teamDescription }}
		.toggle-btn(@click='show = !show'
			:class='{ show }') MEET THE TEAM

	//- List of executive team
	.max-w: transition(name='fade-transition')
		.people(ref='people' v-show='show'): person(
			v-for='person in people'
			:key='person.id'
			:person='person'
			:selection.sync='selection'
			ref='persons')

	//- Set selection to display:none when invisible so it doesn't influence the
	//- grid.  I need a transition so that it doesn't screw up the height
	//- calculation
	transition(name='fade-transition')
		.selection(ref='selection' v-show='!!selection')

			//- Transition between bio states
			height-tween(
				name='fade-transition'
				mode='out-in')
				bio(
					v-if='selection'
					:key='selection.id'
					:person='selection')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		person: require './person'
		bio: require './bio'

	props:
		page: Object

	data: ->
		winW: null
		show: null
		selection: null

	mounted: ->
		@onResize()
		@$win.on 'resize', @onResize
	destroyed: -> @$win.off 'resize', @onResize

	computed:

		# The list of people
		people: -> @$contentful.refs @page.teamBios

		# Get the current number of columns
		columns: -> switch
			when @winW < 768 then 1
			when @winW < 1024 then 2
			else 3

	# When the selection changes, move the bio to after the right row
	watch: selection: -> @moveSelectionEl()

	methods:

		# Store the current page width
		onResize: ->
			@winW = window.innerWidth
			@selection = null # Clear selection so placement isn't weird

		# Put the selected bio in the right spot in the list
		moveSelectionEl: ->

			# Do nothing if no selection
			return unless @selection

			# Find the index of the selected bio
			index = @people.findIndex (person) => person.id == @selection.id

			# Get the index of the end of this row
			endIndex = Math.min(
				@people.length - 1,
				@columns * Math.ceil((index + 1) / @columns) - 1
			)

			# Move the selection container to after the last person in a row
			endingEl = @$refs.persons[endIndex].$el
			@$refs.people.insertBefore @$refs.selection, endingEl.nextSibling

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// These breaks are synced in the JS above
col-2 = tablet-landscape - 1px
col-1 = tablet - 1px

.dream-team
	// Remove gap under image
	line-height 0

.marquee
	text-align center
	background #f3f3f1 // The background of the image
	padding-top rem(100px)
	@media (max-width tablet)
		padding-top rem(55px)
		.image
			margin-top 10px

.headline
	margin-top rem(15px)

.image
	margin-top v-space

.description
	max-width 820px
	font rem(18px)/1.5 gotham
	text-align center
	color near-black
	margin-v v-space
	@media (max-width tablet)
		text-align left
		line-height 1.6
		font-size 14px


// Main styles are in team.vue becasue they are shared
.toggle-btn
	margin-top v-space

// Make columns for people
.people
	padding-bottom rem(100px)
	display flex
	flex-wrap wrap
	gap = rem(30px)
	margin-left -1 * gap
	margin-top @margin-left
	> *:not(.selection)
		width "calc(100%/3 - %s)" % gap
		margin-left gap
		margin-top @margin-left
		@media(max-width col-2)
			width "calc(100%/2 - %s)" % gap
		@media(max-width col-1)
			width 100%

// The selection is always full width
.selection
	width 100%

</style>
