###
A cleaner API for dealing with Cognito
###
AWS = require 'amazon-cognito-identity-js'

# Helper to get at error messgaes
errMsg = (err) -> err.message || JSON.stringify err

# Helper to get a user object from a CognitoUserSession
userFromSession = (session) ->
	user = session.getIdToken().payload
	id: user.sub
	token: session.getAccessToken().getJwtToken()
	name:
		first: user.given_name
		last: user.family_name
	email: user.email
	birthday: user.birthdate

# Service library
export default class Cognito

	# Make the pool from env vars
	constructor: ->
		@pool = new AWS.CognitoUserPool
			UserPoolId: process.env.AWS_USER_POOL_ID
			ClientId: process.env.AWS_USER_POOL_APP_CLIENT_ID

	# Register and login in a user (if they were auto approved) and returns their
	# user object if they were automatically confirmed.
	registerAndLogin: (form) ->
		{ id, confirmed } = await @register form
		return await @login form.email, form.password if confirmed

	# Register a user. Accepts an object of user data (email, password, etc) and
	# returns an object with their user id and whether they were auto-confirmed.
	register: (form) -> new Promise (resolve, reject) =>

		# Submit user data
		@pool.signUp form.email, form.password,
			[
				@userAttr 'given_name', form.name.first
				@userAttr 'family_name', form.name.last
				@userAttr 'birthdate', form.birthday
			], null,

			# Handle response
			(err, result) ->
				if err then reject errMsg err # Failure
				else resolve # Success, return some parts of the result
					id: result.userSub
					confirmed: result.userConfirmed

	# Make a Cognito attribute from a key, val pair
	userAttr: (key, val) -> new AWS.CognitoUserAttribute { Name: key, Value: val }

	# Log in a user given their email and pass
	login: (email, pass) -> new Promise (resolve, reject) =>

		# Assemble the request
		auth = new AWS.AuthenticationDetails Username: email, Password: pass
		user = @makeUser email
		user.authenticateUser auth,

			# Handle success
			onSuccess: (session) -> resolve userFromSession session

			# Handle failure
			onFailure: (err) -> reject errMsg err

	# Retrieve user from local storage
	user: -> new Promise (resolve, reject) =>
		if user = @pool.getCurrentUser()
			user.getSession (err, session) ->
				if err then reject errMsg err
				else if session.isValid() then resolve userFromSession session
				else resolve()
		else resolve()

	# Make a CognitoUser object given their email
	makeUser: (email) -> new AWS.CognitoUser Username: email, Pool: @pool

	# Log the user out
	logout: -> @pool.getCurrentUser()?.signOut()

	# Trigger recover password email to be sent
	forgotPassword: (email) -> new Promise (resolve, reject) =>
		user = @makeUser email
		user.forgotPassword
			onSuccess: (data) -> resolve()
			onFailure: (err) -> reject errMsg err

	# Update password after receiving verification code and log in the user
	# on success
	confirmPassword: ({ email, password, code }) -> new Promise (resolve, reject) =>
		@makeUser(email).confirmPassword code, password,
			onSuccess: (data) => resolve await @login email, password
			onFailure: (err) -> reject errMsg err

# Export a singleton instance
export cognito = new Cognito
