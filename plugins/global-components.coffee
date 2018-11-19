###
Register global components
###

# Buttons
Vue.component 'btn', require 'library/components/btn'
Vue.component 'shadow-btn', require 'library/components/shadow-btn'
Vue.component 'buy-tickets-btn', require '~/components/global/buy-tickets-btn'

# Experience
Vue.component 'experience', require('~/components/global/experience-card').default
Vue.component 'experience-poster', require 'library/components/experience/poster'

# Viewport animation
Vue.component 'scale-via-scroll', require '~/components/global/scale-via-scroll'
Vue.directive 'in-viewport', do ->
	directive = require('vue-in-viewport-directive').default
	directive.defaults.top = -200
	return directive

# Misc
Vue.component 'icon', require 'library/components/icon'
Vue.component 'popper', require '~/components/global/popper'
