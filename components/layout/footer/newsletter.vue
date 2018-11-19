<!--
Newsletter signp
-->

<template lang='pug'>

.newsletter
	.cta Join our newsletter

	//- The form element
	v-form(ref='form' @submit.prevent='onSubmit')
		v-text-field.email(
			label='Email'
			v-model='form.email'
			type='email'
			outline hide-details
			:rules='required')
		btn(secondary type='submit' icon='mail' :loading='submitting')

	//- Show success/fail from form
	v-snackbar(v-model='status.show' top :color='status.type') {{ statusMsg }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import axios from 'axios'
import qs from 'qs'
export default

	mixins: [
		require('~/components/global/forms/mixin').default
	]

	data: -> form: email: ''

	computed:

		# Map form for mailchimp
		mailchimpForm: -> EMAIL: @form.email

	methods:

		# Handle submit
		submit: -> axios.post "/newsletter?#{process.env.MAILCHIMP_QUERY}",
			qs.stringify @mailchimpForm

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

.cta
	font 23px gotham
	text-transform lowercase
	@media(max-width tablet - 1px)
		font-size 20px, true

// The form
.v-form
	margin-top rem(25px)
	display flex

// Make button the same size as input
.btn
	height auto

	// Clear left corners
	border-top-left-radius 0 !important
	border-bottom-left-radius 0 !important

	// Allow to be icon sized
	min-width 0

// Fill the space
.email
	flex-grow 1

	// Apply background color
	>>> .v-input__slot
		background white !important

		// So flush with button
		margin-bottom 0

		// Clear right corners
		border-top-right-radius 0 !important
		border-bottom-right-radius 0 !important

</style>
