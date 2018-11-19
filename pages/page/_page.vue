<!--

-->

<template lang='pug'>
.page
	marquee(:title='page.headline')

	.body.inner-gutter.wysiwyg.body-text(v-html='$marked(page.body)')
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		marquee: require '~/components/global/marquees/headline'

	head: -> @$contentful.seo @page.seo, title: @page.headline

	asyncData: ({ app, params }) ->
		page: await app.$contentful.getEntryBySlug 'page', params.page


</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.body
	padding-v v-space

</style>
