require 'appscript'

class GrowlNotify
  
  class << self
    include Appscript
    
    attr_accessor :application_name, :default_notifications, :notifications, :icon
    @application_name = "Ruby Growl"
    @default_notifications = []
    @notifications = []
    @icon = nil
    
    def config(&block)
      block.call(self)
      register
    end

    def reset!
      [:application_name, :default_notifications, :notifications, :icon].each do |meth|
        send(:"#{meth}=", nil)
      end
    end

    def register
      app("Growl").register(:all_notifications => @notifications, :as_application => @application_name, :default_notifications => @default_notifications)
    end

    def send_notification(options= {})
      defaults = {:title => 'no title', :application_name => @application_name, :description => 'no description', :sticky => false, :priority => 0, :with_name => notifications.first}
      local_icon = @icon
      local_icon = options.delete(:icon) if options.include?(:icon)
      if local_icon
        defaults.merge!(:image_from_location => local_icon)
      end
      app("Growl").notify(defaults.merge(options))
    end
    
    def very_low(options={})
      options.merge!(:priority => -2)
      send_notification(options)
    end
    
    def moderate(options={})
      options.merge!(:priority => -1)
      send_notification(options)
    end
    
    def normal(options={})
      options.merge!(:priority => 0)
      send_notification(options)      
    end
    
    def high(options={})
      options.merge!(:priority => 1)
      send_notification(options)
    end
    
    def emergency(options={})
      options.merge!(:priority => 2)
      send_notification(options)
    end
    
    def sticky!(options={})
      options.merge!(:sticky => true)
      send_notification(options)
    end
  end

end
