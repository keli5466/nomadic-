# Add pathify plugin
import pathify, { make } from 'vuex-pathify'
pathify.options.deep = 2 # Allow creating new subproperties
export plugins = [ pathify.plugin ]

export state = ->
	shade: false # Whether to show global shade
	showBuyDialog: false # Whether to show the buy tickets dialog
	showBuyComingSoonDialog: false # The coming soon dialog

# Use pathify mutators
export mutations = make.mutations(state)

export actions =

	# Load initial data
	nuxtServerInit: ({ dispatch }, { env }) -> Promise.all [
			dispatch 'experiences/fetch'
			dispatch 'locations/fetch'
			dispatch 'listings/fetch'
		]
