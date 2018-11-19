<!--
FAQ page
-->

<template lang='pug'>
.faq

	//- Marquee
	headline(:title='page.headline')

	//- FAQ List
	faqs(:faqs='faqs')

	//- Location Block
	locations


</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { get } from 'vuex-pathify'
export default

	components:
		headline: require '~/components/global/marquees/headline'
		'mobile-headline': require '~/components/global/marquees/mobile-headline'
		locations: require '~/components/global/locations'
		faqs: require '~/components/global/faq-list'

	head: -> @$contentful.seo @page.seo, title: @page.headline

	# Load page data
	asyncData: ({ app }) ->
		page: await app.$contentful.getEntry 'faq'

	computed:
		faqs: -> @$contentful.refs @page.faqs


</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>



</style>
