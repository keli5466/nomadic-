<!--
Team page
-->

<template lang='pug'>
.team

	//- Marquee
	marquee(:title='page.headline'
		:subhead='page.subhead')

	//- Body columns
	.body.inner-gutter.wysiwyg.body-text(v-html='body')

	//- Dream team block
	people(:page='page')

	//- News listing
	news(:articles='news')

	//- Partner Block
	.partner-block#partners
		.header.inner-gutter
			img(src='~/assets/imgs/bug.svg' style='height: 32px')
			h2.headline2 {{ page.partneringHeadline }}
			p.copy {{ page.partneringSubhead }}

		//- Partner Touts
		.touts(v-if='page.partneringTouts.length'): tout(
			v-for='tout in $contentful.refs(page.partneringTouts)'
			:key='tout.id'
			:body='tout.body'
			to='/contact'
			:background='tout.background'
			:mobileBackground='tout.mobileBackground')

	//- Offices list
	offices

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		offices: require '~/components/global/offices'
		marquee: require '~/components/global/marquees/headline'
		people: require '~/components/team/people'
		tout: require '~/components/global/full-tout'
		news: require '~/components/team/news'

	head: -> @$contentful.seo @page.seo, title: @page.headline

	# Load page data
	asyncData: ({ app }) ->
		page: await app.$contentful.getEntry 'team'

	# Get data needed for offices
	fetch: ({ store }) -> store.dispatch 'offices/fetch'

	computed:

		news: -> @$contentful.refs @page.news

		# Break up the body into columns
		body: ->
			columns = @page.body.split('###').slice(1)
			open = "<div class='col'>\n\n###"
			close = "\n\n</div>"
			@$marked "#{open}#{columns.join("#{close}#{open}")}#{close}"


</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>


.body
	background light-white-gradient
	padding-v v-space

	// Style contents
	>>>

		// Make columns
		display flex
		justify-content space-between
		.col
			width calc(100%/3 - 4rem)
			margin-bottom 20px // accounts for the extra spacing at the bottom of the block
		@media(max-width tablet-landscape - 1px)
			.col
				width calc(100%/3 - 2rem)
		@media(max-width tablet - 1px)
			display block
			padding-v 25px
			.col
				width auto
				text-align center
				h3
					line-height 1.77
					font-size 26px, true

		// Headers
		h3
			font rem(30px) gothic
			text-transform lowercase
			margin-top 0
			color black
			line-height 1.53
			margin-bottom rem(15px)
			text-align center

		// Copy
		p
			font-family gotham
			color near-black

// Toogle button style for artcles and team bio
>>> .toggle-btn
	border blue 1px solid
	border-radius menu-border-radius
	max-width 275px
	margin-h auto
	text-align center
	font-size 12px
	text-transform uppercase
	line-height 1.3
	font-weight 500
	padding rem(16px) 12px rem(10px)
	&:after
		color blue
		margin-top 5px //Wiggle room
		font-size rem(10px)
		content icon-chevron-down
		font-family icomoon
		display block
		transition transform 0.3s
	// Click animation
	&.show:after
			transform rotate(180deg)
	&:hover
		cursor pointer

.header
	padding-v v-space
	text-align center
	background rgba(#e4e4e4, 0.44)
	.headline2
		line-height 1.15
		margin-top rem(15px)
		margin-bottom 24px

.copy
	max-width rem(820px)
	margin-h auto
	font-size 18px
	line-height 1.5
	color near-black
	@media (max-width tablet)
		text-align left
		line-height 1.6
		font-size 14px

// Add seperator above offices for mobile when the tout image is shown above
// the tout
.partner-block
	@media(max-width tablet - 1px)
		&:after
			content ''
			display block
			margin-h mobile-gutter // Need to add gutters
			border-bottom grey-border
			margin-top v-space-mobile
			margin-bottom v-space-mobile * .75 // Looks better

</style>
