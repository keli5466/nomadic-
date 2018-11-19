<!--
A temporary dialog that is wired to all buy links
-->

<template lang='pug'>

v-dialog(v-model='show' max-width='400' content-class='buy-coming-soon')
	v-card
		v-card-text
			h3 Coming soon!
			p So you want to be among the first to experience Nomadic? Sign up here for news, updates, and VIP ticket sales.

			//- The newsletter from the footer
			newsletter

		//- I don't think we need to show this
		//- v-card-actions: btn.close(@click='show = false') Close

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { sync } from 'vuex-pathify'
export default

	components: newsletter: require '~/components/layout/footer/newsletter'

	computed:

		# Sync up the show state
		show: sync 'showBuyComingSoonDialog'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Make the snackbar fro the newsletter visible
/ >>> .buy-coming-soon
	overflow visible

h3
	margin-bottom 1em
	font-weight 500
	line-height: 1.1

p
	line-height 1.7

.newsletter
	margin-top 1em
	>>> .cta
		display none

</style>
