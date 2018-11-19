# Deps
{ getEntries, config, refs } = require 'bukwild-contentful-utils'
isString = require 'lodash/isString'
module.exports = {}

# Configure the contentful utils, this runs before registration of module
config
	space: process.env.CONTENTFUL_SPACE
	access_token: process.env.CONTENTFUL_API
	host: process.env.CONTENTFUL_HOST
	timeout: 5 * 60 * 1000 # 5 mins

# Helper for making routes
addRoute = (routes, contentType, makeRoute) ->
	{ items:entries } = await getEntries contentType, limit: 1000
	refs(entries).forEach (entry) ->
		if route = makeRoute entry
			routes.push
				route: route
				seo: entry?.seo?.fields

# Build the list of all routes for generating static files
module.exports.forGenerate = ->
	routes = []

	# Add all experiences
	await addRoute routes, 'experience', (entry) ->
		"/experiences/#{entry.slug}" if entry.status == 'Active'

	# Add all pages
	await addRoute routes, 'page', (entry) ->
		"/page/#{entry.slug}"

	# Return list of routes
	return routes

# Flatten this object to an array of paths for use by the sitemap module
module.exports.forSitemap = ->
	routes = await module.exports.forGenerate()
	routes.map (route) ->
		if isString route
		then route
		else route.route
	.filter (route) -> !!route # Clear empties
