<!--
An invidual slide
-->

<template lang='pug'>

v-carousel-item
	scale-via-scroll(:disable='disableScaleViaScroll')
		visual(v-if='isVideo' fill :video='video')
		visual(v-else fill :image='asset')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props:
		asset: Object
		width: Number
		height: Number
		disableScaleViaScroll: Boolean

	computed:

		# Is this a video type
		isVideo: -> !!@asset?.fields?.file?.contentType?.match /^video/

		# Calc poster size
		posterWidth: -> Math.round @width * 0.1
		posterHeight: -> Math.round @height * 0.1

		# If there is a video, pull it
		video: -> @asset?.fields?.file?.url

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>



</style>
