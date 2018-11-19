###
Shared code on account forms
###
get = require 'lodash/get'
module.exports =

	components:
		password: require './password'

	data: ->
		valid: false # The validation state
		emailError: null # Manual errors shown on email field
		submitting: false # Loading state

		# No-ops
		submitAction: '' # The vueX action
		form: {} # The form data
		rules: {} # Rules keyed by field

	watch:

		# Emit events during submit lifecycle
		valid:
			immediate: true
			handler: -> @$emit 'valid', @valid
		submitting:
			immediate: true
			handler: -> @$emit 'submitting', @submitting

	methods:

		# Validate using the rules at the provided key
		validate: (path) -> [ (val) =>
				rule = get(@rules, path)
				try rule.validateSync val
				catch e then return e.message
				return true
			] # An array is expected

		# Submit login form
		submit: ->
			return unless @valid and not @submitting
			@submitting = true
			try user = await @$store.dispatch @submitAction, @form
			catch e then return @emailError = e.message || e
			finally @submitting = false
			@$emit 'success', user

		# Reset the form
		reset: -> @$refs.form.reset()
