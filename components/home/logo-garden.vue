<!--

-->

<template lang='pug'>


.logo-garden(v-if='brands.length')

	//- Headline
	.headline3.tablet Featured In

	//- Logos
	.logos
		a.logo(
			v-for='brand in brands' :key='brand.id'
			:href='brand.url' target='_blank')
			visual(
				:image='$contentful.img(brand.logo, 360, 140)'
				background='')


</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default
	props: brands: Array
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

logo-margin = rem(20px)

.logo-garden
	text-align center
	padding-v v-space - logo-margin
	padding-h mobile-gutter
	@media (max-width tablet - 1px)
		padding-top v-space-mobile
		padding-bottom v-space-mobile - logo-margin

.logos
	display flex
	justify-content space-around
	flex-wrap wrap
	margin-h auto
	align-items center

.headline3
	margin-bottom rem(40px)

.logo
	max-width rem(180px)
	margin logo-margin

</style>
