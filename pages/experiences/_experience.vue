<!--
An experience detail page
-->

<template lang='pug'>

.experience-page

	//- Marquee
	marquee(:experience='experience')

	//- Features list
	features(:experience='experience')

	//- What to expect
	tout(
		reverse
		headline='What to expect from this experience'
		:body='experience.expectationNotes'
		:background='experience.expectationBackground'
		:mobileBackground='experience.expectationMobileBackground')
	tout(
		headline='What parents need to know'
		:body='experience.parentsNotes'
		:background='experience.parentsBackground'
		:mobileBackground='experience.parentsMobileBackground')
		age(slot='subhead' :experience='experience')

	//- Locations list
	locations

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		marquee: require '~/components/experience/marquee'
		features: require '~/components/experience/features'
		tout: require '~/components/global/full-tout'
		age: require 'library/components/experience/card/recommended-age'
		locations: require '~/components/global/locations'

	# SEO
	head: -> @$contentful.seo @experience.seo,
		title: @experience.title
		description: @experience.description
		image: @experience.poster

	computed:

		# Get this specific experience
		experience: -> @$store.get 'experiences/find', @$route.params.experience

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Different orientation for recomended age
.recommended-age
	@media(min-width tablet + 1px)
		justify-content flex-start !important

</style>
