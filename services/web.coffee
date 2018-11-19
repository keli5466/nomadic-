###
The Serverless APIs for the web service
###

# Deps
import axios from 'axios'

# Service class
export default class WebApi

	# Build Axios client
	constructor: -> @client = axios.create baseURL: process.env.WEB_API_ENDPOINT

	# Proxy the basic Axios methods
	get: -> @client.get.apply null, arguments
	post: -> @client.post.apply null, arguments
	put: -> @client.put.apply null, arguments
	delete: -> @client.delete.apply null, arguments

# Export a singleton
export api = new WebApi
