<!--
The login form from the header
-->

<template lang='pug'>

v-form(ref='form' v-model='valid')

	//- Email
	v-text-field(
		label='Email'
		type='email'
		v-model='form.email'
		:rules='validate("email")'
		:error-messages='emailError'
		@input.native='emailError = null'
		@keyup.enter='submit')

	//- Password
	password(
		v-model='form.password'
		:rules='validate("password")'
		@input.native='emailError = null'
		@submit='submit')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { rules } from '~/store/auth'
export default

	mixins: [ require './account-form' ]

	data: ->
		submitAction: 'auth/login'
		rules: rules
		form:
			email: ''
			password: ''

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

</style>
