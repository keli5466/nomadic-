###
Recalculate scroll monitor when pages change
###
import scrollMonitor from 'scrollmonitor'
document.addEventListener 'after-loader-leave', ->
	scrollMonitor.recalculateLocations()
