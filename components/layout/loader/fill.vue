<!--
The logo within the transition
-->

<template lang='pug'>

transition: .fill(v-if='show')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default
	props: show: Boolean

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.fill
	expand white
	background white-gradient
	width 100vw
	height 100vh

	// Fade in
	&.v-enter-active
		transition opacity .9s ease-in-quad
	&.v-leave-active
		transition opacity .3s ease-in
	&.v-enter, &.v-leave-to
		opacity 0

</style>
