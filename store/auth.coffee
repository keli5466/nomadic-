###
Store the user's session
###

###
# Disable for now

# Deps
import { make } from 'vuex-pathify'
import { string } from 'yup'
import { cognito } from '~/services/cognito'

# Wait a tick to update global state to allow local components to respond to
# promises during auth actions before they are affected to the global state.
# For instance, global state may affect the showing and hiding of components
# which removes their event listeners _before_ those listeners can process the
# login / logout, etc.
nextTick = (cb) -> setTimeout cb, 0

# The cart contents
export state = -> user: null

# Use pathify mutators
export mutations = make.mutations(state)

export getters =

	# Make user name
	name: ({ user }) -> "#{user.name.first} #{user.name.last}" if user

export actions =

	# Get user data from session
	init: ({ commit }) ->
		if user = await cognito.user()
			nextTick -> commit 'SET_USER', user
			return user

	# Log in a user
	login: ({ commit }, { email, password }) ->
		if user = await cognito.login email, password
			nextTick -> commit 'SET_USER', user
			return user

	# Register and login a user
	register: ({ commit }, account) ->
		if user = await cognito.registerAndLogin account
			nextTick -> commit 'SET_USER', user
			return user

	# Logout a user
	logout: ({ commit }) ->
		cognito.logout()
		nextTick -> commit 'SET_USER', null

	# Update the password after forgot password flow
	confirmPassword: ({ commit }, payload) ->
		if user = await cognito.confirmPassword payload
			nextTick -> commit 'SET_USER', user
			return user

# Validation rules for account fields
export rules =
	email: string().email().required()
	password: string().required()
		.min 8, 'Password must be 8 characters long'
		.matches /[A-Z]/, 'Password must contain an uppercase letter'
		.matches /[a-z]/, 'Password must contain a lowercase letter'
		.matches /[\d]/, 'Password must contain a number'

###
