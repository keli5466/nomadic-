<!--
The buy tickets btn
-->

<template lang='pug'>

btn.buy-tickets-btn(
	secondary
	:menu='menu'
	:block='block'
	:gradient='gradient'
	icon='ticket'
	iconColor='#fff'
	@click='$store.set("showBuyComingSoonDialog", true)') Buy tickets
	//- @click='$emit("click")') Buy tickets

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props:

		# Pass through props
		block: Boolean
		menu: Boolean
		gradient:
			type: Boolean
			default: true

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>



</style>
