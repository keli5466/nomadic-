<!--

-->

<template lang='pug'>

.article
	visual.logo(
		:image='article.image'
		background='contain'
		background-position='left')
	.date {{ article.date | date }}
	.exerpt {{ article.excerpt }}
	.actions: btn(grey wide :href='article.url' target='_blank') Read More

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import format from 'date-fns/format'
export default

	props: article : Object

	filters: date: (val) -> format val, 'MM/YY'


</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Article card
.article
	background white
	max-width rem(380px)
	width 32%
	display flex
	flex-direction column
	border solid 0.8px #eaeaea
	min-height rem(390px)
	oval-shadow()
	margin-bottom rem(60px)
	padding rem(50px) rem(45px) rem(35px)

	// Chaneg width after tablet
	@media (max-width tablet - 1px)

		// Give a fixed width
		width 80vw
		flex-shrink 0

		// Gutter between articles
		&:not(:first-child)
			margin-left mobile-gutter

	@media (max-width mobile)
		padding-h 18px

.logo
	width 100%
	margin-bottom rem(32px)
	height 70px

.date
	font-size 14px
	font-weight 500
	line-height 2.43
	color red

.actions
	margin-top auto

// Render button as block after beak
.btn
	@media (max-width tablet - 1px)
		width 100%

.exerpt
	font-size 19px
	line-height 1.56
	color near-black
	margin-top 5px
	padding-bottom rem(58px)

	// Restore large font size on mobile
	@media(max-width tablet - 1px)
		font-size 18px, true

</style>
