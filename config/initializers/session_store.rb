ActionController::Base.session = {
  :namespace   => '_dalli-rails2_session',
  :secret => 'a9d5b3645da8e334cef0decf5fbf9537a31abf6818852f158a97e7b224fd8c812454d026623a6f5cc90dac28c856a91efca0ce02f91e7e29a62eee7a2a021514'
}

require 'action_controller/session/dalli_store'
ActionController::Base.session_store = :dalli_store