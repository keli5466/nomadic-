/**
 * Global Vuetify packages
 * @type {Object}
 */
import Vue from 'vue'
import {
	Vuetify,
	VApp,
	VBtn,
	VCard,
	VCarousel,
	VExpansionPanel,
	VDialog,
	VForm,
	VInput,
	VSelect,
	VSnackbar,
	VTextField,
	VTextarea,
	VToolbar,
	transitions,
} from 'vuetify'
import Touch from 'vuetify/es5/directives/touch'

Vue.use(Vuetify, {
	theme: {
		primary: '#39b4e7', // Nomadic blue
		secondary: '#ff6635', // Nomadic red/orange
		error: '#ff6635',
		success: '#39b4e7',
	},
	components: {
		VApp,
		VBtn,
		VCard,
		VCarousel,
		VExpansionPanel,
		VDialog,
		VForm,
		VInput,
		VSelect,
		VSnackbar,
		VTextField,
		VTextarea,
		VToolbar,
		transitions,
	},
	directives: {
		Touch
	}
})
