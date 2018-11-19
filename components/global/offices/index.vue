<!--
The contact vue
-->

<template lang='pug'>

.offices.carousel-info-selector

	//- The offices carousel
	v-fade-transition(mode='out-in'): carousel.max-w(
		:key='selection.id'
		:media='media')

	//- The selector
	.selector.max-w
		h2.headline3 contact headquarters
		v-select(
			solo
			v-if='officesForSelect.length > 1'
			append-icon='icon-chevron-down'
			:items='officesForSelect'
			v-model='selection'
			hide-details)
		.single-selector(v-else) {{selection.city}}, {{selection.state}}

	//- The selected office
	.vp-fade.info-container(v-in-viewport.once)
		v-fade-transition(mode='out-in'): contact(
			:key='selection.id'
			:office='selection')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { get } from 'vuex-pathify'
export default

	components:
		carousel: require '~/components/global/media-carousel'
		contact: require './contact'

	# Set offices to the offices data that was fetched during hydration
	data: -> selection: null

	# Set an initial selection
	created: -> @selection = @offices?[0]

	computed:

		# Get the list of offices from vuex
		offices: get 'offices/list'

		# Map the offices for the select menu
		officesForSelect: -> @offices.map (location) ->
			value: location
			text: "#{location.city}, #{location.state}"

		# Media carousel
		media: -> @selection.slideshow

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' src='~/components/global/carousel-info-selector.styl' scoped></style>

<style lang='stylus' scoped>

.offices

	// Push offices list down on desktop
	@media (min-width tablet)
		margin-top v-space

</style>
