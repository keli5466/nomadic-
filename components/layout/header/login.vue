<!--
The login button and the menus it shows
-->

<template lang='pug'>

v-menu(
	v-model='show'
	offset-y left
	:close-on-content-click='false'
	:min-width='300'
	:max-width='300')
	v-btn(flat slot='activator') Login

	//- The menus
	v-card
		v-card-text

			//- Login menu
			div(v-if='state == "login"' key='login')
				login-form(
					ref='login'
					@valid='valid = $event'
					@submitting='submitting = $event'
					@success='show = false')
				p: a(@click='state = "forgot"') Forgot password?

			//- Forgot password menu
			forgot-form(
				ref='forgot'
				v-else key='forgot'
				@valid='valid = $event'
				@submitting='submitting = $event'
				@success='show = false')

		//- Action buttons
		v-card-actions
			v-btn(@click='cancel') {{ cancelLabel }}
			v-btn(
				color='primary'
				:loading='submitting'
				:disabled='!valid'
				@click='submit') Submit

</template>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<script lang='coffee'>
export default

	components:
		'login-form': require '~/components/global/auth/login'
		'forgot-form': require '~/components/global/auth/forgot'

	data: ->
		show: false # Whether to show the menu
		state: 'login' # Whether logging in or forgot passwording
		valid: false # Validation state of the given
		submitting: false # Submitting status

	computed:

		# Cancel button text
		cancelLabel: ->
			if @state == 'login'
			then 'Close'
			else 'Cancel'

	watch:

		# Reset the state when opening
		show: -> @state = 'login' if @show

	methods:

		# If on forgot password, cancel goes back to login.  If on login, close.
		cancel: ->
			if @state == 'login'
			then @show = false
			else @state = 'login'

		# Pass submit clicks to interior forms
		submit: -> @$refs[@state]?.submit()

</script>

<!-- ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– -->

<style lang='stylus' scoped>



</style>
