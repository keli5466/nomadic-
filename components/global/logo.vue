<!--
The nomadic logo
-->

<template lang='pug'>

span.logo
	img.bug(src='~/assets/imgs/bug.svg' style='height: 3.125rem')
	icon.text(name='logo' height='0.8em')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Size the logo
.logo
	font-size rem(45px)

// Push the text part over
.text
	margin-left 0.25em


</style>
