<!--
List of game features
-->

<template lang='pug'>

.experience-features.max-w(v-if='experience.features.length')

	//- Intro
	h2.headline4.vp-scale-up(v-in-viewport.once v-if='experience.featureHeadline') {{ experience.featureHeadline }}

	//- The list of features
	.features-wrap
		.features.vp-translate-y.staggered(v-in-viewport.once): feature(
			v-for='feature in $contentful.refs(experience.features)'
			:key='feature.id'
			:feature='feature')

	//- Link to faqs
	.actions.vp-scale-up(v-in-viewport.once): shadow-btn: btn(
		primary wide
		nuxt to='/faq') General FAQs

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components: feature: require './feature'

	props: experience: Object

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

gutter = rem(80px)
innter-gutter = rem(60px)
gap = rem(20px)

.experience-features
	padding-v gutter

// The headline
.headline4
	text-align center
	padding-bottom innter-gutter
	max-width rem(850px)
	margin-h auto

.features-wrap
	max-width 1280px
	margin-h auto

// List of features
.features
	width 100%

	// Columns
	display flex
	flex-wrap wrap
	margin-left -0.5 * gap
	margin-top @margin-left
	> *
		width "calc((100%/3) - %s)" % gap
		margin-left gap
		margin-top gap
		flex-shrink 0

		// Break to 2
		@media(max-width tablet-landscape)
			width "calc((100%/2) - %s)" % gap

	// Break to 1
	@media(max-width tablet)
		display block
		margin-left 0
		margin-top 0
		> *
			width 100%
			margin-left 0
			margin-top 0

// Container of CTA buttons
.actions
	text-align center
	padding-top innter-gutter

</style>
