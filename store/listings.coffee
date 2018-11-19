###
Get a list of all Nomadic listings, which are the pivot table between locations
and experiences.  This gets used in getters on experiences / listings which
connects the two tables
###
import { make } from 'vuex-pathify'
{ getEntries, refs, ref } = require 'bukwild-contentful-utils'

# Store
export state = -> list: []

# Use pathify mutators
export mutations = make.mutations(state)

# Getter functions the help parse pivot relations
export getters =

	# Filter by an experience
	whereExperience: ({ list }) -> (experience) -> list.filter (listing) ->
		listing.experience?.sys.id == experience.sys.id

	# Get the locations for a given experience
	locationsForExperience: ({ }, { whereExperience }, { locations } ) ->
		(experience) ->
			whereExperience(experience).map (listing) ->

				# Find the location entry
				location = locations.list.find (location) ->
					location.sys.id == listing.location?.sys.id

				# Add the xola button id
				{ ...location, xolaButtonId: listing.xolaButtonId } if location

			# Remove empties
			.filter (location) -> !!location

	# Filter by a location
	whereLocation: ({ list }) -> (location) -> list.filter (listing) ->
		listing.location?.sys.id == location.sys.id

export actions =

	# Fetch the full list
	fetch: ({ commit }, slug) ->
		{ items } = await getEntries 'listing', include: 0
		commit 'SET_LIST', refs items
