<!--
A feature on the experience page
-->

<template lang='pug'>

.experience-feature
	.icon: visual(
		:image='$contentful.img(feature.icon)'
		background='contain'
		width='100%'
		aspect='1')
	.copy
		h3.title {{ feature.title }}
		p.description.body-text(v-unorphan) {{ feature.description }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props: feature: Object

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.experience-feature
	background inverse-light-white-gradient
	border-radius menu-border-radius
	padding mobile-gutter
	position relative

	// Create columns
	display flex

// Icon col
.icon
	padding-right rem(30px)
	width rem(55px) + @padding-right
	flex-shrink 0

.title
	font rem(20px) gothic
	margin-top rem(5px) // Push off of top of icon
	@media(max-width tablet)
		font-size 20px, true

.description
	margin-top rem(8px)

</style>
