# Load all icons from assets/icons/*.svg
icons = require.context('~/assets/icons/', true, /\.svg$/)
icons.keys().forEach(icons)
