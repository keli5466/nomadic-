###
Handle timing with the loader / page mask
###
import { make } from 'vuex-pathify'
import { wait } from '~/plugins/utils'

# State that is promises.  IE 11 wasn't chill with storing promises in the Vuex
# state natively.  I also included completeDone in here as well, which stores
# a function, but I thought I'd just store all these non-scalars/booleans
# right here.
canHide = Promise.resolve()
complete = Promise.resolve()
completeDone = null

# Start site the loader visible and ready to be removed
export state = -> visible: true

# Use pathify mutators
export mutations = make.mutations(state)

export getters =

	# Passthrough Promise-based state vars.  These return functions to take
	# advantage of Pathify invoking these when accesed via $store.$get so as to
	# get cached Promises.
	canHide: -> -> canHide
	complete: -> -> complete

export actions =

	# Show the loader
	show: ({ commit }) ->
		commit 'SET_VISIBLE', true

		# This promise tracks when the loader intro animation has reached the
		# middle point but loading isn't necessarily done
		canHide = new Promise (resolve) -> wait 1000, -> resolve()

		# This promise will resolve when animation has reached middle and is loaded
		complete = new Promise (resolve) -> completeDone = resolve

	# Hide the loader when it's ready to be hidden
	hide: ({ commit }) ->
		await canHide
		completeDone?()
		commit 'SET_VISIBLE', false
