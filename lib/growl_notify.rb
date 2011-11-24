require 'growl_notify_osascript'

# Alias as GrowlNotify
unless Object.const_defined?('GrowlNotify')
  GrowlNotify = GrowlNotifyOsascript
end