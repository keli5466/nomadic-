<!--
Display list of articles in a carousel
-->

<template lang='pug'>

.article-carousel(v-touch='{ left: onLeft, right: onRight}')
	.articles(:style='offset')
		article-card(
			v-for='article in articles'
			:key='article.id'
			:article='article'
			ref='articles')
	.controls(v-if='articles.length > 1'): .dot(
		v-for='dot, index in articles'
		:key='dot.id'
		:class='{ active: index == active }'
		@click='active = index'): .shape

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
noUnit = (val) -> parseInt val, 10
export default

	components: 'article-card': require './article'

	props: articles: Array

	data: ->
		active: 0
		cardWidth: 0

	# Listen for resizes
	mounted: ->
		@$win.on 'resize', @onResize, throttle: 100
		@onResize()
	destroyed: -> @$win.off 'resize', @onResize

	computed:

		# Computed the offset of the container.  It's the margin left plus the width
		# of the card
		offset: ->
			transform: "translateX(#{@active * @cardWidth * -1}px)"

	methods:

		# Handle swipes
		onLeft: -> @active = Math.min @active + 1, @articles.length - 1
		onRight: -> @active = Math.max @active - 1, 0

		# Measure the size of the article on resize
		onResize: ->
			return unless el = @$refs.articles?[1]?.$el
			style = getComputedStyle el
			@cardWidth = noUnit(style.width) +
				noUnit(style.marginLeft) +
				noUnit(style.borderLeft) +
				noUnit(style.borderRight) + 1

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

dot-pad = 12px

.articles
	display flex

	// Animate translation changes
	transition transform .5s ease-in-out-quint

.controls
	display flex
	justify-content center

	// Compenate for padding on dots
	margin-bottom dot-pad * -1

// Speerate with padding to increase click target size
.dot
	button()
	padding dot-pad

	// Draw the dot shape
	.shape
		circle 10px, border-grey
		transition background .3s ease-out-quart

	// Hover
	&:not(.active)
		+hover()
			.shape
				background dark-blue

	// Active state
	+active()
		.shape
			background blue


</style>
