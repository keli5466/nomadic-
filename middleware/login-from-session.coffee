# Automatically pull Cognito user data from local storage into Vuex
export default ({ store }) ->
	store.dispatch 'auth/init' if process.client
