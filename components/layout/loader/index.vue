<!--
The per page-loader
-->

<template lang='pug'>

.loader
	fill(:show='visible')
	intro-mask(:show='visible')

	//- Debugging
	//- btn(@click='visible = !visible') Toggle

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { sync } from 'vuex-pathify'
import { disableBodyScroll, enableBodyScroll } from 'body-scroll-lock'
import {
	disable as disableInViewportDirective,
	enable as enableInViewportDirective } from 'vue-in-viewport-directive'
export default

	components:
		'intro-mask': require './mask'
		'fill': require './fill'

	# On mounted, like when the site first loads, reveal the site
	mounted: -> @$wait 1000, => @$store.dispatch 'loader/hide'

	computed:

		# Sync visible state with loader
		visible: sync 'loader/visible'

	# Watch visible state
	watch: visible:
		immediate: true
		handler: ->
			if @visible
				@preventScrollWhileVisible()
				disableInViewportDirective()
			else
				@$wait 300, => enableInViewportDirective()
				@$wait 500, => @notifyWhenLoaderRemoved()

	methods:

		# The interface used by Nuxt's loader config api
		start: -> @$store.dispatch 'loader/show'
		finish: -> @$store.dispatch 'loader/hide'

		# Toggle body scroll on and off.  Must wait till we reach mid point so the
		# page doesn't scroll up at start of transition
		preventScrollWhileVisible: ->
			return unless window?
			await @$store.get 'loader/canHide'
			disableBodyScroll @$el
			await @$store.get 'loader/complete'
			enableBodyScroll @$el

		# Fire a root level event when the loader animation is finished
		notifyWhenLoaderRemoved: ->
			document?.dispatchEvent new CustomEvent 'after-loader-leave'

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Standard positioning
.loader
	position fixed
	z-index header-z + 1

.btn
	top 5px
	left 5px
	opacity .1

</style>
