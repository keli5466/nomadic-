<!--
The contact form for a given office
-->

<template lang='pug'>

.contact-form.max-w

	//- The address column
	address-unit.third.break-at-three-col(:location='office')

	//- The form column
	h3-unit.form-col(title='Message us')
		v-form(ref='form' @submit.prevent='onSubmit')
			//- Name
			.two-col
				.fieldset
					label(:class='{required : required}') Name
					v-text-field(
						label='First name'
						v-model='form.firstName'
						outline hide-details
						:rules='required')
					v-text-field(
						label='Last name'
						v-model='form.lastName'
						outline hide-details
						:rules='required')

				//- Email
				.fieldset
					label(:class='{required : required}') Email
					v-text-field(
						v-model='form.email'
						outline hide-details single-line
						type='email'
						:rules='required')

			//- Subject
			.fieldset
				label(:class='{required : required}') Subject
				v-text-field(
					v-model='form.subject'
					outline hide-details single-line
					:rules='required')

			//- Message
			.fieldset
				label(:class='{required : required}') Message
				v-textarea(
				v-model='form.message'
				outline hide-details single-line
				:rules='required')

			//- Footer line from form
			footer
				.notes Required
				.actions: btn(
					primary
					type='submit'
					:loading='submitting') Send

	//- Show success/fail from form
	v-snackbar(v-model='status.show' top :color='status.type') {{ statusMsg }}

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
import { api } from '~/services/web'
export default

	mixins: [
		require('~/components/global/forms/mixin').default
	]

	components:
		'h3-unit': require '~/components/global/h3-unit'
		'address-unit': require '~/components/global/h3-unit/address'

	props: office: Object

	data: ->
		form:
			officeId: @office.id
			firstName: null
			lastName: null
			email: null
			subject: null
			message: null

	computed:

		# The message to show in response to form submit
		statusMsg: -> switch @status.type
			when 'success' then 'Message recieved, you\'ll hear back from us soon.'
			else 'There was an error with your message, please try again.'

	methods:

		# Handle form submit
		submit: -> api.post '/office/contact', @form

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>

// Make columns
.contact-form
	width 100%
	display flex
	justify-content space-between

	// Make the form the remaiing space
	.form-col
		h3-width = 32%
		width h3-width * 2 + (100% - h3-width*3) * 0.5

	// Stack
	@media (max-width three-col-break )
		display block
		.form-col
			width 100%
			margin-top v-space * 1.4

</style>

<!-- The form styles -->
<style lang='stylus' src='./form.styl' scoped></style>
