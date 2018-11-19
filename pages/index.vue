<!--
Nomadic home page
-->

<template lang='pug'>

.homepage

	//- Marquee video
	marquee(
		:headline='page.headline'
		:subhead='page.subhead'
		:image='page.marqueePoster'
		:video='page.marqueeVideo'
		:scroll='true'
		:youtube='page.marqueeYoutube')

	//- About tout
	tout.about(
		:body='about.body'
		:background='about.background'
		:mobileBackground='about.mobileBackground'
		to='/about'
		cta='See More')

	//- The list of experiences
	.experiences: experience(
		v-for='experience in experiences'
		:key='experience.id'
		:experience='experience')

	//- Render homepage quotes
	quotes(:quotes='$contentful.refs(page.quotes)')

	//- Logo Garden
	logos(:brands='$contentful.refs(page.logoGarden)')

	//- Locations list
	locations

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { get } from 'vuex-pathify'
export default

	components:
		marquee: require '~/components/global/marquees/video'
		tout: require '~/components/global/full-tout'
		quotes: require '~/components/home/quotes-carousel'
		logos: require '~/components/home/logo-garden'
		locations: require '~/components/global/locations'

	# SEO
	head: -> @$contentful.seo @page.seo,
		title: @page.headline
		description: @page.subhead

	# Get page data
	asyncData: ({ app }) ->
		page: await app.$contentful.getEntry 'home'

	computed:

		# The current location data
		experiences: get 'experiences/active'

		# The about tout
		about: -> @$contentful.ref(@page.tout)

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Increase size of about header
.about
	// moves copy content to left on home page only
	text-align left !important
	>>> .body h2
		font-size 40px

	// Center on mobile
	@media(max-width tablet - 1px)
		text-align center

</style>
