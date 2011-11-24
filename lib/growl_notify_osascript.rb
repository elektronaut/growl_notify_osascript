# encoding: utf-8

require 'open3'

class GrowlNotifyOsascript
  VERSION = "0.0.1"
  class GrowlNotFound < Exception; end
  class << self
    
    attr_accessor :application_name, :default_notifications, :notifications, :icon
    @application_name = "Ruby Growl"
    @default_notifications = []
    @notifications = []
    @icon = nil
    
    def config(&block)
      block.call(self)
      register
    end
    
    def escape(string)
      '"' + string.to_s.gsub('"', '\"') + '"'
    end

    def run_script(script)
  	  output = Open3.popen3('osascript') do |i, o, ts|
  	    i.puts script
  	    i.close
  	    o.gets
	    end
      output ? output.strip : nil
    end

    def reset!
      [:application_name, :default_notifications, :notifications, :icon].each do |meth|
        send(:"#{meth}=", nil)
      end
    end

    def to_applescript(hash)
      hash.map do |key, value|
        unless value.nil?
          name = key.to_s.gsub('_', ' ')
          if value.kind_of?(Array)
            "#{name} {" + value.map{|v| escape(v)}.join(', ') + "}" 
          else
            "#{name} " + escape(value)
          end
        end
      end.compact.join(' ')
    end

    def register
      raise GrowlNotFound unless running?
      
      script = "tell application id \"com.Growl.GrowlHelperApp\"\n" + 
               "register " +
               to_applescript(
                 :as_application => @application_name,
                 :all_notifications => @notifications,
                 :default_notifications => @default_notifications
               ) + 
               "\nend tell"
               
      run_script(script)
    end
    
    def running?
      script = "tell application \"System Events\"\n" +
      	       "set isRunning to count of (every process whose bundle identifier is \"com.Growl.GrowlHelperApp\") > 0\n" +
               "end tell"
      run_script(script) == 'true'
    end

    def send_notification(options= {})
      raise GrowlNotFound unless running?
      defaults = {:title => 'no title', :application_name => @application_name, :description => 'no description', :sticky => false, :priority => 0, :with_name => notifications.first}
      local_icon = @icon
      local_icon = options.delete(:icon) if options.include?(:icon)
      if local_icon
        defaults.merge!(:image_from_location => local_icon)
      end
      
      opts = defaults.merge(options)
      
      script = "tell application id \"com.Growl.GrowlHelperApp\"\n" + 
               "notify " +
               to_applescript(opts) +
               "\nend tell"
      
      run_script(script)
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