require 'spec_helper'
ICON = File.join(File.expand_path('../', __FILE__), 'growl_icon.png')
describe GrowlNotifyOsascript do
  it "should reset the configs" do
    GrowlNotifyOsascript.config do |config|
      config.notifications = config.default_notifications = ["foo"]
      config.application_name = config.notifications.first
    end
    GrowlNotifyOsascript.notifications.should == ["foo"]
    GrowlNotifyOsascript.reset!
    GrowlNotifyOsascript.notifications.should be_nil
  end
  after :each do
    GrowlNotifyOsascript.reset!
  end
  
  context 'application not found' do
    before do
      GrowlNotifyOsascript.stubs(:running?).returns(false)
    end
    
    it "should raise correct error" do
      lambda {
        GrowlNotifyOsascript.config do |config|
          config.notifications = config.default_notifications = ["Compass Application"]
          config.application_name = config.notifications.first
        end
        GrowlNotifyOsascript.normal(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my "normal" message').should be_nil
      }.should raise_error GrowlNotifyOsascript::GrowlNotFound
    end
  end
  
  context 'default' do
    before do
      GrowlNotifyOsascript.config do |config|
        config.notifications = config.default_notifications = ["Compass Application"]
        config.application_name = config.notifications.first
      end
    end
  
    it "should send a growl notification with icon" do
      GrowlNotifyOsascript.send_notification(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my descripton', :icon => ICON).should be_nil
    end
  end
  
  context 'no icon' do
    before do
      GrowlNotifyOsascript.config do |config|
        config.notifications = config.default_notifications = ["Compass Application"]
        config.application_name = config.notifications.first
      end
    end
  
    it "should send a growl notification with icon" do
      GrowlNotifyOsascript.send_notification(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my descripton no icon').should be_nil
    end
  end
  
  context 'config with icon' do
     before do
        GrowlNotifyOsascript.config do |config|
          config.notifications = config.default_notifications = ["Compass Application"]
          config.application_name = config.notifications.first
          config.icon = ICON
        end
      end

      it "should send a growl notification with icon" do
        GrowlNotifyOsascript.send_notification(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my descripton with a global icon').should be_nil
      end
  end
  
  context "helper methods" do
    before do
       GrowlNotifyOsascript.config do |config|
         config.notifications = config.default_notifications = ["Compass Application"]
         config.application_name = config.notifications.first
         config.icon = ICON
       end
     end

     it "should send 'very low'" do
       GrowlNotifyOsascript.very_low(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my "very_low" message').should be_nil
     end
     
     it "should send 'moderate'" do
       GrowlNotifyOsascript.moderate(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my "moderate" message').should be_nil
     end
     
     it "should send 'normal'" do
       GrowlNotifyOsascript.normal(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my "normal" message').should be_nil
     end
     
     it "should send 'high'" do
       GrowlNotifyOsascript.high(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my "high" message').should be_nil
     end
     
     it "should send 'emergency'" do
       GrowlNotifyOsascript.emergency(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my "emergency" message').should be_nil
     end
     
     it "should send 'sticky'" do
       GrowlNotifyOsascript.sticky!(:title => 'GrowlNotifyOsascript Spec', :description => 'This is my "Sticky!" message').should be_nil
     end
     
  end
  
end