<!--
Video marquee, like on the homaepage
-->

<template lang='pug'>

visual.video-marquee(
	ref='visual'
	:image='image'
	:video='videoSrc')

	//- The inner content
	transition(:duration='4000'): .copy.max-w(v-show='show')
		.headline-shift: h1.headline(v-if='headline' v-html='$marked(headline)')
		a.play(v-if='youtube' :href='youtube' @click.prevent='open = true')
			icon(name='play' height='64')
		.subhead-shift: h2.subhead(v-if='subhead' v-html='$marked(subhead)')

	//- Youtube embed dialog
	v-dialog(content-class='video-dialog' v-model='open')
		.player: div(ref='youtube')

	.scroll-down(v-if='scroll' @click='scrollDown')
		.icon-chevron-down
</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { get } from 'vuex-pathify'
export default

	props:
		headline: String
		subhead: String
		image: Object
		video: Object
		youtube: String
		scroll: Boolean

	data: ->
		show: false # Whether to show the copy, synced with loader state
		open: false # Open state of Youtube video
		sdkLoaded: false # Whether Youtube is loaded

	computed:

		# The video
		videoSrc: -> @$contentful.ref(@video)?.file.url

		# Parse the youtube id from the URL
		# https://stackoverflow.com/a/6904504/59160
		youtubeId: ->
			regex = ///
				(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)
				|youtu\.be\/)([^"&?\/ ]{11})
				///i
			@youtube.match(regex)?[1]

		# The page mask state
		loaderVisible: get 'loader/visible'

	watch:

		# When dialog is open, pause visual video
		open: ->
			if @open
				@$refs.visual.pause()
				if @sdkLoaded
					@player.seekTo(0)
					@player.playVideo()
				else @loadYoutubeSDK()
			else
				@$refs.visual.play()
				@player?.pauseVideo()

		# Show the copy after mask hides
		loaderVisible:
			immediate: true
			handler: ->
				if not @loaderVisible
					@show = false
					@$wait 1000, => @show = true

	methods:

		# Load the Youtube SDK
		loadYoutubeSDK: ->
			return if @sdkLoaded
			@sdkLoaded = true
			script = document.createElement 'script'
			script.src = 'https://www.youtube.com/iframe_api'
			document.head.appendChild script
			window.onYouTubeIframeAPIReady = @initPlayer

		# Init player
		initPlayer: -> @player = new YT.Player @$refs.youtube,
			videoId: @youtubeId
			playerVars:
				autoplay: @open # Autoplay if still open
				modestbranding: 1

		scrollDown: ->
			@$scrollTo(@$el.nextSibling)

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Add build in transitions
introTransition()
	.copy.v-enter-active &
		{block}
introStart()
	.copy.v-enter &,.copy.v-leave-to &
		{block}

// Scroll Down
.scroll-down
	transition transform .3s
	position absolute
	bottom 40px
	left 50%
	transform translateX(-50%)
	+hover(true)
		cursor pointer
		transform scale(1.1) translateX(-50%)
		transition-duration .1s
// Needed to remove scroll down from the copy container and have it be relative to the whole marquee
>>>.vv-slot
	position static

// Fill screen
.video-marquee
	background black
	width 100%
	margin-top header-h * -1 // So animating in headers on home overlap
	height 100vh
	min-height 400px // Eyeballed
	@media (max-width mobile)
		.headline
			font-size rem(68px)
		.max-w
			padding-h 3rem

	// Default typography
	color white

// Explicity set z-index for IE11
.copy
	position relative
	z-index 1

// Marquee h1
.headline
	font rem(92px)/0.9 gothic


	// Intro
	+introTransition()
		transition transform 1s ease-out-quint, opacity 1s
	+introStart()
		opacity 0
		transform translateY(rem(-60px))

.headline
.subhead
	// TM or R
	>>>span
		font-size rem(16px)

// The play button in marquee
.play
	display inline-block
	margin-top rem(15px)
	>>>svg
		height 99%
		width 99%

	// Add hover
	transition transform .3s, color .5s
	+hover(true)
		transform scale(1.1)
		transition-duration .1s

	// Intro
	+introTransition()
		transition transform 0.9s ease-out-quint, opacity 0.9s
	+introStart()
		opacity 0

// The h2
.subhead
	font rem(24px) gothic
	margin-top rem(20px)

	// Intro
	+introTransition()
		transition transform 1s ease-out-quint, opacity 1s
	+introStart()
		opacity 0
		transform translateY(rem(60px))

// Don't allow video player to exceed the max-width
/ >>> .video-dialog
	max-width 'calc(%s - %s)' % (max-w (mobile-gutter * 2))

// Apply aspect ratio to player
.player
	aspect-ratio(16/9)
	background black
	width 100%
	position relative
	>>> iframe
		expand()

</style>
