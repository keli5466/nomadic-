###
List of experiences that are used throughout site
###
import { make } from 'vuex-pathify'
{ getEntries, refs, ref } = require 'bukwild-contentful-utils'

# Store
export state = -> list: []

# Use pathify mutators
export mutations = make.mutations(state)

export getters =

	# Get the list of experiences mapped with their locations
	list: ({ list }, {}, {}, rootGetters) ->
		list.map (experience) -> Object.assign {}, experience,
			locations: rootGetters['listings/locationsForExperience'](experience)

	# Get active experiences
	active: ({}, { list }) ->
		list.filter (experience) -> experience.status == 'Active'

	# Get coming soon experiences
	comingSoon: ({}, { list }) ->
		list.filter (experience) -> experience.status == 'Coming soon'

	# Get a specific experience by it's slug
	find: ({}, { list }) -> (slug) ->
		list.find (experience) -> experience.slug == slug

export actions =

	# Fetch the full list
	fetch: ({ commit }, slug) ->
		{ items } = await getEntries 'experience',
			order: 'fields.order,fields.title'
			'fields.status[ne]': 'inactive'
		commit 'SET_LIST', refs items
