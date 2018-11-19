###
Inject Marked so it can be used from templates
###
import marked from 'marked'

# Customize marked
marked.setOptions
	breaks: true

# Export plugin
export default ({ }, inject) ->

	# Wrap marked with condition that allows specifying inline rendering (no
	# wrapping p tag)
	# https://github.com/markedjs/marked/issues/395#issuecomment-41511822
	inject 'marked', (str = '', inline = false) ->
		if inline
		then marked.inlineLexer str, []
		else marked str
