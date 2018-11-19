<!--
Quotes caoursel
-->

<template lang='pug'>

v-expansion-panel
	v-expansion-panel-content.max-w(
	v-for='faq in faqs',
	:key='faq.id'
	expand-icon='icon-chevron-down')
		.question(slot='header') {{ faq.question }}
		.answer
			| {{ faq.answer }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props: faqs: Array

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>
.v-expansion-panel
	box-shadow none
	&__container
		padding-right rem(56px)
		padding-v rem(33px)
		transition background-color 100ms smooth-in-out
		&--active
			background-color #f7f7f7!important

	>>> &__header
		padding 0
		min-height auto
		.v-expansion-panel__container--active &
			font-weight 500
	@media (max-width tablet)
		border-bottom grey-border
		&__container
			padding-right mobile-gutter

.question
	font-size 20px
	line-height 1.2
	color black

.answer
	font-size 18px
	margin-top 25px
	margin-bottom rem(10px) //wiggle room EB
	line-height 1.22
	color near-black
</style>
