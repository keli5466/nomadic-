<!--
Shade overlay, borrowing the effect from Vuetify
-->

<template lang='pug'>

v-fade-transition: .v-overlay.v-overlay--active(v-if='show')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { get } from 'vuex-pathify'
export default

	computed:

		# Get whether to show the shade from vuex
		show: get 'shade'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// This is generally what the overlay i
.v-overlay
	z-index 200

</style>
