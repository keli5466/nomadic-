<!--

-->

<template lang='pug'>

.news-block.inner-gutter
	h3.headline2 in the news
	grid.desktop(:articles='articles')
	carousel.tablet(:articles='articles')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>

export default

	props: articles: Array

	components:
		grid: require './grid'
		carousel: require './carousel'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>
mobile-gap = rem(340px + 30px)

.news-block
	padding-v v-space
	background-image light-white-gradient

// Block title
.headline2
	text-align center
	margin-bottom rem(50px)

</style>
