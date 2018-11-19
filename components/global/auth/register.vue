<!--
The register form during checkout
-->

<template lang='pug'>

v-form(
	ref='form'
	v-model='valid'
	@submit='$emit("submit")')

	//- Name fielsds
	.names
		v-text-field(
			label='First name'
			v-model='form.name.first'
			:rules='validate("name.first")'
			@keyup.enter='submit')
		.gutter
		v-text-field(
			label='Last name'
			v-model='form.name.last'
			:rules='validate("name.last")'
			@keyup.enter='submit')

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
		label='Password'
		v-model='form.password'
		:rules='validate("password")'
		@submit='submit')

	//- Birthday
	birthday(
		v-model='form.birthday'
		:rules='validate("birthday")')

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>

# Make validation rules
import { rules as authRules } from '~/store/auth'
import { string } from 'yup'
rules = {
	...authRules
	name:
		first: string().required()
		last: string().required()
	birthday: string().required()
}

# Component def
export default

	mixins: [ require './account-form' ]

	components:
		birthday: require 'library/components/form/birthday'

	data: ->
		submitAction: 'auth/register'
		rules: rules
		form:
			name:
				first: ''
				last: ''
			email: ''
			password: ''
			birthday: ''

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Make columns for name fields
.names
	display flex
	.gutter
		width 20px

</style>
