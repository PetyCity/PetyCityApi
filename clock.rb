require './config/boot'
require './config/environment'
require 'clockwork'

module Clockwork
 every(1.month, 'delete.transaction') {
   Transaction.destroy_all
 }
end