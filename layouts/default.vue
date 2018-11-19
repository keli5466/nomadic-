<!--
Site layout
-->

<template lang='pug'>

v-app.default-layout

	//- Header bar
	layout-header

	//- The app container
	nuxt

	//- Site footer
	layout-footer

	//- Global shade overlays
	shade-overlay

	//- Dialogs
	waiver-signed
	//- buy-tickets
	buy-coming-soon

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:

		# Layout
		'layout-header': require '~/components/layout/header'
		'layout-footer': require '~/components/layout/footer'

		# Dialogs
		'waiver-signed': require '~/components/layout/dialogs/waiver-signed'
		# 'buy-tickets': require '~/components/layout/dialogs/buy-tickets'
		'buy-coming-soon': require '~/components/layout/dialogs/buy-coming-soon'

		# Overlays
		'shade-overlay': require '~/components/layout/shade-overlay'

	# Append site name to the title
	head: -> titleTemplate: if @$route.path == '/' then '%s' else "%s | Nomadic"

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.application

	// Default font
	font-family gotham
	line-height 1
	display block

	// Clear Vuetify
	background none

// Set a global max-width
>>> .application--wrap
	max-width max-w
	margin-h auto
	overflow hidden
	background white

	// Compensate for absolute positioned header
	padding-top header-h

</style>
