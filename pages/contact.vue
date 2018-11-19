<!--
The contact page
-->

<template lang='pug'>

.contact

	//- The marquee header
	mobile-headline(title='Contact')
	headline.desktop(:title='page.headline')

	//- Location list
	headline.tablet(title='our locations')
	locations

	//- Offices list
	headline.tablet(title='our headquarters')
	offices

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		headline: require '~/components/global/marquees/headline'
		'mobile-headline': require '~/components/global/marquees/mobile-headline'
		locations: require '~/components/global/locations'
		offices: require '~/components/global/offices'

	# SEO
	head: -> @$contentful.seo @page.seo, title: @page.headline

	# Load page data
	asyncData: ({ app }) -> page: await app.$contentful.getEntry 'contact'

	# Load offices using method provided by contact component
	fetch: ({ store }) -> store.dispatch 'offices/fetch'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Style the contact page differently on mobile
.offices, .locations
	@media (max-width tablet - 1px)
		>>>

			// Reduce padding on selector
			.v-select
				margin-top 0
				padding-top 0

			// Hide selectors prompt
			.headline3
				display none

			// Hide nomadic logo
			.logo
				display none

</style>
