<!--
A dialog shown to users after they sign the waiver
-->

<template lang='pug'>

v-dialog(v-model='show' max-width='400')
	v-card
		v-card-text
			h3 Waiver signed
			p Thank you for filling out our safety waiver in advance!  You can continue filling out waivers or close this window.
		v-card-actions
			btn.close(@click='show = false') Close
			btn.another(primary :href='waiverUrl') Fill another waiver

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	data: -> show: false

	# Auto-open on deep link
	mounted: ->
		@show = true if @$route.query.event == 'waiverSigned'

	computed:

		# The href to fill another waiver
		waiverUrl: ->
			"https://waiver.smartwaiver.com/auto/?\
				auto_waiverid=#{process.env.SMARTWAIVER_GUID}&\
				auto_tag=#{@$route.query.orderShortCode}&\
				auto_anyoneelseneedtosign=0"

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

h3
	margin-bottom .5em
	font-weight 500
	line-height: 1.1

p
	line-height 1.3

// Hide close on mobile to make room
@media(max-width 370px)
	.close
		display none

</style>
