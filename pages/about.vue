<!--
The "What is Nomadic" page
-->

<template lang='pug'>

.about-page

	//- Marquee
	marquee(
		:headline='page.headline'
		:subhead='page.subhead'
		:image='page.marqueePoster'
		:video='page.marqueeVideo'
		:youtube='page.marqueeYoutube'
		:style='{ height: marqueeHeight}')

	//- Intro text
	.intro.max-w(
		ref='intro'
		v-if='page.intro')
		.copy.headline4(v-balance-text) {{ page.intro}}

	//- List of touts
	.touts(v-if='page.touts.length')
		//- Seperate First one to add button
		tout(
			v-for='tout in $contentful.refs(page.touts).slice(0,1)'
			:key='tout.id'
			:body='tout.body'
			popup
			cta='RESERVE TICKETS'
			:background='tout.background'
			:mobileBackground='tout.mobileBackground')
		tout(
			v-for='tout in $contentful.refs(page.touts).slice(1)'
			:key='tout.id'
			:body='tout.body'
			:background='tout.background'
			:mobileBackground='tout.mobileBackground')

	//- Locations block
	locations

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		marquee: require '~/components/global/marquees/video'
		tout: require '~/components/global/full-tout'
		locations: require '~/components/global/locations'

	# SEO
	head: -> @$contentful.seo @page.seo, title: 'What is nomadic'

	# Load page data
	asyncData: ({ app }) -> page: await app.$contentful.getEntry 'about'

	# Calculate intro height
	data: -> introHeight: 0
	mounted: ->
		@measureIntroHeight()
		@$win.on 'resize', 	@measureIntroHeight, throttle: 100
	destroyed: -> @$win.off 'resize', 	@measureIntroHeight

	computed:

		# Adjust the height of the visual to make room for the intro
		marqueeHeight: -> "calc(100vh - #{@introHeight}px)"

	methods:

		# Store the intro height
		measureIntroHeight: -> @introHeight = @$refs.intro.offsetHeight

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// The intro paragraph
.intro
	padding-v v-space
	background light-white-gradient
	.copy
		max-width rem(850px)
		margin-h auto
		text-align center

// Increase size of about header
.full-tout >>> .body h2
	font-size 32px
	line-height 1.2

</style>
