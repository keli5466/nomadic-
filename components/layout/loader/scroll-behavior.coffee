# Wait until the loader is complete to reset scroll position to the top
module.exports = (to, from, savedPosition) ->
	await window?.$nuxt?.$store.get 'loader/complete'
	return { x:0, y:0 }
