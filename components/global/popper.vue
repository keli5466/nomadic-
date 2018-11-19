<!--
Customized Vue-popper instance
-->

<template lang='pug'>

no-ssr: vue-popper(
	ref='popper'
	append-to-body
	:trigger='smartTrigger'
	:options='config'
	:transition='transition'
	:enter-active-class='`${transition}-enter-active`'
	:leave-active-class='`${transition}-leave-active`'
	@show='$emit("update:open", true)'
	@hide='$emit("update:open", false)')

	//- The contents
	.popper: slot

	//- Activator
	slot(name='activator' slot='reference')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
# import 'vue-popperjs/dist/css/vue-popper.css'
export default

	components:
		'vue-popper': require 'vue-popperjs'

	props:
		open: Boolean
		trigger:
			type: String
			default: 'click'
		placement:
			type: String
			default: 'top'
		offsetX:
			type: String
			default: '0px'
		offsetY:
			type: String
			default: '20px'

	computed:

		# Popper config
		config: ->
			placement: @placement
			modifiers:
				offset: offset: "#{@offsetX}, #{@offsetY}"
				preventOverflow: padding: 20

		# If touch, don't hover
		smartTrigger: -> if Modernizr?.touchevents then 'click' else @trigger

		# Make the transition name
		transition: -> "popper-#{@placement}"

		# Is the popper open
		isOpen: -> @$refs.popper?.showPopper

	# Listen for proxied clicks
	mounted: -> document.addEventListener 'proxy-click', @onProxyClick
	destroyed: -> document.removeEventListener 'proxy-click', @onProxyClick

	methods:

		# Relay close calls
		close: -> @$refs.popper.doClose()

		# Listen for manully created clicks and if the original target was not
		# inside the activator and this popper is open, close the popper
		onProxyClick: (e) ->
			button = @$slots.activator[0].elm
			@close() if @isOpen && !button.contains e.detail.target

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Arrow size
arrow-size = rem(7px)

// Clear popper styles
.popper
	box-shadow none
	border grey-border
	border-radius menu-border-radius
	background near-white
	text-align left
	padding 0
	z-index popper-z

	// Replace popper arrow with rotated square solution
	>>> .popper__arrow
		square arrow-size * 2, near-white
		position absolute
		margin 0

		// Rotate to make triangle
		transform-origin bottom left
		transform rotate(45deg)

	// For top oriented menu
	&[x-placement^='top']
		margin-top arrow-size * -1
		>>> .popper__arrow
			bottom 0
			border-bottom grey-border
			border-right grey-border

	// For bottom oriented menu
	&[x-placement^='bottom']
		margin-top arrow-size
		>>> .popper__arrow
			top 'calc(%s * -2 + 1px)' % arrow-size
			border-top grey-border
			border-left grey-border

</style>

<style lang='stylus'>

// Transition
.popper-top-enter-active,
.popper-top-leave-active,
.popper-bottom-enter-active,
.popper-bottom-leave-active
	transition-duration .4s
	.popper
		transition opacity .2s, top .4s ease-out-quad
.popper-top-enter,
.popper-top-leave-to,
.popper-bottom-enter,
.popper-bottom-leave-to
	.popper
		opacity 0
.popper-top-enter,
.popper-top-leave-to
	.popper
		top -20px !important
.popper-bottom-enter,
.popper-bottom-leave-to
	.popper
		top 20px !important

</style>
