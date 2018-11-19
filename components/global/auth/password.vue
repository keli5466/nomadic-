<!--
A password input, mimics:
https://vuetifyjs.com/en/components/text-fields#example-password
-->

<template lang='pug'>

v-text-field(
	:label='label'
	v-model='password'
	:append-icon='plaintext ? "visibility_off" : "visibility"'
	:type='plaintext ? "text" : "password"'
	:rules='rules'
	@click:append='plaintext = !plaintext'
	@keyup.enter='$emit("submit")')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	props:
		label:
			type: String
			default: 'Password'
		value: String
		rules: Array

	data: -> plaintext: false

	computed:

		# Passthrough value changes
		password:
			get: -> @value
			set: (value) -> @$emit 'input', value

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>



</style>
