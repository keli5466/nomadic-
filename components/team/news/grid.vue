<!--
The article grid, only show 3 until load more is clicked
-->

<template lang='pug'>

.article-grid
	transition-group.articles(tag='div' name='fade')
		article-card(
			v-for='article in articles.slice(0, showAll ? undefined : 3)'
			:key='article.id'
			:article='article')
	.toggle-btn(
		@click.once='showAll = true'
		v-if='!showAll') More News

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props: articles: Array

	components:
		'article-card': require './article'

	data: -> showAll: false

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Article Wrapper
.articles
	display flex
	justify-content space-between
	flex-wrap wrap
	padding-bottom rem(50px)

</style>
