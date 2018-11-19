###
Get a list of all Nomadic offices
###
import { make } from 'vuex-pathify'
{ getEntries, refs, ref } = require 'bukwild-contentful-utils'

# Store
export state = -> list: []

# Use pathify mutators
export mutations = make.mutations(state)

export actions =

	# Fetch the full list
	fetch: ({ commit }, slug) ->
		{ items } = await getEntries 'office',
			order: 'fields.city'
		commit 'SET_LIST', refs items
