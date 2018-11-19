
// Inject the Xola SDK for rendering the checkout widget
(function() { var co=document.createElement("script"); co.type="text/javascript"; co.async=true; co.src="https://sandbox.xola.com/checkout.js"; var s=document.getElementsByTagName("script")[0]; s.parentNode.insertBefore(co, s); })();

// Expose plugin def
export default ({ app }, inject) => {

	// Listen for Orders to be recreated and redirect to the order detail page
	// window.addEventListener('message', ({ data, origin }) => {
	// 	if (data.event == 'xolaOrderCreate') {
	//
	// 		// Close the dialog
	// 		xola.checkoutClose()
	//
	// 		// Clear old Xola state
	// 		const el = document.getElementById('xola-multi-item-checkout-app')
	// 		if (el) {
	// 			el.remove()
	// 			xola.multiItemCheckout = null
	// 		}
	//
	// 		// Show order detail
	// 		app.router.push(`/orders/${data.orderId}`)
	// 	}
	// })

}
