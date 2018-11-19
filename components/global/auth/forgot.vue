<!--
Forgot and recover password form
-->

<template lang='pug'>

v-form(ref='form' v-model='valid' @submit.prevent)

	//- Enter email
	.enter-email(v-if='state == "email"')
		p Supply your email and we'll email you a verification code that you can
			|  use to reset your password.

		//- User email
		v-text-field(
			label='Email'
			type='email'
			v-model='form.email'
			:rules='validate("email")'
			:error-messages='emailError'
			@input.native='emailError = null'
			@keyup.enter='submit')

	//- Enter pass
	.enter-pass(v-else)
		p Check <b>{{ form.email }}</b> for a verification code. Enter it below as
			|  well as your new password. Or
			a(@click='state = "email"')  enter a different email.

		//- Verification code
		v-text-field(
			label='Verification code'
			v-model='form.code'
			mask='######'
			:rules='validate("code")'
			:error-messages='codeError'
			@input.native='codeError = null'
			@keyup.enter='submit')

		//- Password
		password(
			label='New password'
			v-model='form.password'
			:rules='validate("password")'
			@input.native='codeError = null'
			@submit='submit')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { cognito } from '~/services/cognito'

# Make validation rules
import { rules as authRules } from '~/store/auth'
import { string } from 'yup'
rules = {
	...authRules
	code: string().required().min(6).max(6)
}

# Component def
export default

	mixins: [ require './account-form' ]

	data: ->
		state: 'email'
		rules: rules
		codeError: ''
		form:
			email: ''
			code: ''
			password: ''

	methods:

		# Submit the new password
		submit: ->
			if @state == 'email'
			then @forgotPassword()
			else @confirmPassword()

		# Lookup the user's email
		forgotPassword: ->
			return unless @valid and not @submitting
			@submitting = true
			try await cognito.forgotPassword @form.email
			catch e then @emailError = e
			finally @submitting = false
			@state = 'password' # Switch to enter password form

		# Confirm password
		confirmPassword: ->
			return unless @valid and not @submitting
			@submitting = true
			try user = await @$store.dispatch 'auth/confirmPassword', @form
			catch e then return @codeError = e.message || e
			finally @submitting = false
			@$emit 'success', user

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

p
	margin-bottom 30px

</style>
