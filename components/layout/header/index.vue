<!--
The site header
-->

<template lang='pug'>

transition: header(v-show='show'): .max-w-wide

	//- Logo
	.left: nuxt-link(to='/'): logo

	.right

		//- Links
		primary-link(to='/about') what is nomadic
		primary-link(to='/experiences') our experiences
		primary-link(to='/faq') FAQs

		//- Buy button
		buy-tickets-btn(@click='$store.set("showBuyDialog", true)')

	//- Using this Instead of SYNC to style everything first
	hamburger.hamburger(:class='{open: open}'
		:open.sync='open'
		color='linear-gradient(to bottom, #ff6635, #ea4915 43%, #d03706)'
		:width=30
		:pad=0
		:gap=5
		:stroke=3
		@click='open = !open')

	transition(name='slide-in')
		nav-menu(v-show='open')

		//- Disable login for now

			//- Logged in menu
			v-menu(v-if='user' offset-y left)
				v-btn(flat slot='activator')
					| {{ user.name.first }}
					v-icon keyboard_arrow_down
				v-list
					v-list-tile Account
					v-list-tile(@click='$store.dispatch("auth/logout")') Logout

			//- Logged out menu
			login-menu(v-else)

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { get } from 'vuex-pathify'
export default

	mixins: [
		require('./scroll-lock').default
	]

	components:
		'logo': require '~/components/global/logo'
		'primary-link': require './primary-link'
		'nav-menu': require './mobile-menu'
		hamburger: require 'vue-hamburger'

	# Hide the header on the initial render if the loader is visible
	data: -> show: @shouldShowOnMount()

	computed:

		# Get the active user
		# user: get 'auth/user'

		# Gets hidden during page transition
		loaderVisible: get 'loader/visible'

	watch:

		# If there is a video marquee and the loader was open, stagger the reveal
		# of the header.
		loaderVisible: ->
			if !@show and !@loaderVisible
				@$wait 450, => @show = true

	methods:

		# Show header on mount as long as we're not on the homepage and the the
		# is visible
		shouldShowOnMount: ->
			if @$route.path == '/' and @$store.get 'loader/visible'
			then false else true

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

barHeight = 3px
barSpace = 5px

header
	position absolute
	rectangle 100%, header-h, white
	z-index header-z
	top 0
	left 0

	// Animate in
	&.v-enter-active
		transition transform 1.5s ease-in-out-quint
	&.v-enter, &.v-leave-to
		transform translateY(-100%)

	// Center contents
	flex-center()
	.max-w-wide
		width 100%
		display flex
		justify-content space-between
		align-items center
		height 100%

// Makes btn wider to match design
.buy-tickets-btn
	min-width 185px

// Right side oriented stuff
.right
	margin-left auto
	display flex
	align-items center
	max-width rem(688px)
	width 100%
	@media (max-width tablet - 1px)
		display none

	// Spread appart items
	> *
		margin-left auto

// Left side oriented stuff
.left
	flex 0 0 auto

// Mobile nav
.hamburger
	button()
	z-index 100
	margin-left auto
	display block
	@media (min-width tablet)
		display none
>>>
	.line
		border-radius 3px
	.hamburger-button.open .line
		background white!important

</style>
