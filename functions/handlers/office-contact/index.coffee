###
Send a contact submission to a user
Based on https://github.com/lakshmantgld/aws-ses-serverless-example
###

# Deps
AWS = require 'aws-sdk'
ses = new AWS.SES()
contentful = require('contentful').createClient
	space: process.env.CONTENTFUL_SPACE
	accessToken: process.env.CONTENTFUL_API
	host: process.env.CONTENTFUL_HOST

# Lambda body
module.exports = (request) ->

	# Parse the body
	form = JSON.parse request.body
	console.debug 'Form', JSON.stringify form

	# Lookup the form in Contentful
	{ fields: office } = await contentful.getEntry form.officeId
	console.debug 'Office', JSON.stringify office

	# Prepare the message
	message =
		Source: process.env.CONTACT_FORM_SOURCE
		Destination: ToAddresses: [ office.contact ]
		Message:
			Subject: Data: "Nomadic contact submission: #{form.subject}"
			Body: Html: Data: buildBody form

	# Send the mail
	console.debug 'Sending', JSON.stringify message
	await ses.sendEmail(message).promise()

	# Return success
	statusCode: 200
	headers: 'Access-Control-Allow-Origin': '*'

# Put together the body of the message
buildBody = (form) -> """
	<p><b>Name:</b> #{form.firstName} #{form.lastName}</p>
	<p><b>Email:</b> #{form.email}</p>
	<p><b>Subject:</b> #{form.subject}</p>
	<p><b>Message:</b> #{form.message}</p>
"""
