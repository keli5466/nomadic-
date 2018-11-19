###
Render function for experience card
###

# Deps
import card from'library/components/experience/card'
import buyLocationSelectBtn from'~/components/global/buy-location-select'

# Functional component def
export default
	functional: true

	# Register same props
	props: card.props

	render: (create, context) ->
		{ props } = context
		url = "/experiences/#{props.experience.slug}"
		create card,

			# Pass through all props but add URL
			props: Object.assign { }, props, { url }

			# Make the action buttons
			scopedSlots: actions: -> [
				createLearnMore create, context, url
				createBuyButton create, context
			]

# Make the learn more button
createLearnMore = (create, { props }, url) ->
	return if props.noLearnMore
	create Vue.component('shadow-btn'),
		props: block: true
		scopedSlots: default: -> create Vue.component('btn'),
			props:
				nuxt: true
				primary: true
				block: true
				to: url
			scopedSlots: default: -> "What it's Like?"

# Create the buy button
createBuyButton  = (create, { props, listeners }) ->

	# Make the buy location select menu
	buyBtn = create buyLocationSelectBtn,
		props:
			block: true
			experience: props.experience
		on: toggle: (bool) -> listeners.buyToggle?(bool)

	# Conditionally wrap in shadow button
	if props.noShadowBtns
	then buyBtn
	else create Vue.component('shadow-btn'),
		props: block: true
		scopedSlots: default: -> buyBtn
