<!--
The location selector / footer element
-->

<template lang='pug'>

.locations.carousel-info-selector

	//- Locations carousel
	v-fade-transition(mode='out-in'): carousel(
		:key='selection.id'
		:media='media')

	//- Location selector
	.selector.max-w
		img.logo.tablet(src='~/assets/imgs/bug.svg' style='height: 2.5rem')
		h2.headline3 find us
		v-select(
			solo
			v-if='locationsForSelect.length > 1'
			append-icon='icon-chevron-down'
			:items='locationsForSelect'
			v-model='selection'
			hide-details)
		.single-selector(v-else) {{selection.city}}, {{selection.state}}

	//- Current location info
	.vp-fade.info-container(v-in-viewport.once)
		v-fade-transition(mode='out-in'): info(
			:key='selection.id'
			:location='selection')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { get } from 'vuex-pathify'
export default

	components:
		carousel: require '~/components/global/media-carousel'
		info: require './info'

	data: -> selection: null

	# Set an initial selection
	created: -> @selection = @locations?[0]

	computed:

		# Get the list of locations from vuex
		locations: get 'locations/list'

		# Map the locations for the select menu
		locationsForSelect: -> @locations.map (location) ->
			value: location
			text: "#{location.name} - #{location.city}, #{location.state}"

		# Media carousel
		media: -> @selection.slideshow

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' src='~/components/global/carousel-info-selector.styl' scoped></style>
