<!--
List of experiences page
-->

<template lang='pug'>

.experiences-page

	//- Marquee
	marquee(
		:title='page.headline'
		:subhead='page.subhead')

	//- The list of experiences
	.experiences
		experience(
			v-for='experience,index in active'
			:key='experience.id'
			:experience='experience'
			:color='index % 2 == 0 ? "red": "blue"'
			:direction='index % 2 == 0 ? "right": "left"')
		experience(
			v-for='experience,index in comingSoon'
			:key='experience.id'
			:experience='experience'
			:color='(index + active.length) % 2 == 0 ? "red" : "blue"'
			:direction='(index + active.length) % 2 == 0 ? "right" : "left"')

	//- Locations list
	locations

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { get } from 'vuex-pathify'
export default

	components:
		marquee: require '~/components/global/marquees/headline'
		locations: require '~/components/global/locations'

	# SEO
	head: -> @$contentful.seo @page.seo,
		title: @page.headline
		description: @page.subhead

	# Get page data
	asyncData: ({ app }) ->
		page: await app.$contentful.getEntry 'experiences'

	computed:

		# Get list of experiences
		active: get 'experiences/active'
		comingSoon: get 'experiences/comingSoon'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>



</style>
