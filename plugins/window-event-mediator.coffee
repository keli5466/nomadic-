# Only create window-event-mediator client side
import win from 'window-event-mediator'
export default ({ }, inject) -> inject 'win', win
