###
Shared form logic, desgined to work with a snackbar to show success / fail
messages
###
export default

	data: ->

		# Loading status
		submitting: false

		# Form fields
		form: {}

		# Generic rule that makes a field required
		required: [ (val) -> !!val]

		# Post submit status
		status:
			show: false
			type: null

	computed:

		# The message to show in response to form submit
		statusMsg: -> switch @status.type
			when 'success' then "We've recieved your submission, thanks!"
			else 'There was an error with your submission, please try again.'

	methods:

		# Handle submit
		onSubmit: ->
			return unless @$refs.form.validate()
			@submitting = true
			try
				await @submit()
				@setStatus 'success'
				@$refs.form.reset()
			catch e
				console.error e
				@setStatus 'error'
			finally @submitting = false

		# No-op submit method
		submit: ->

		# Set the status
		setStatus: (type) ->
			@status.type = type
			@status.show = true
