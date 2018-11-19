// Boot Coffeescript
require('coffeescript/register')

// Expose handlers
module.exports = {
	officeContact: require('./handlers/office-contact/index.coffee'),
}
