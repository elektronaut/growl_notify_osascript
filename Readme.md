# GrowlNotifyOsascript

This is a fork of Scott Davis' excellent [GrowlNotify gem](https://github.com/scottdavis/growl_notify).

The original is based on the rb-appscript bindings to Applescript, which unfortunately doesn't support Kernel::fork. This gem uses Applescript piped through the osascript utility instead.

## Usage

### Configuring

    GrowlNotify.config do |config|
      config.notifications = ["Compass Application", "Someother Notification"]
      config.default_notifications = ["Compass Application"] 
      config.application_name = "My Application" #this shows up in the growl applications list in systems settings
    end

You can also set a globally scoped icon:

    GrowlNotify.config do |config|
      config.notifications = ["Compass Application", "Someother Notification"]
      config.default_notifications = ["Compass Application"] 
      config.application_name = "My Application" #this shoes up in the growl applications list in systems settings
      config.icon = File.join("SOME PATH")
    end
    
### Using

#### Notification levels:

1. very_low: `GrowlNotify.very_low(:title => 'HELLO WORLD', :description => 'Man that was cool')`
2. moderate: `GrowlNotify.moderate(:title => 'HELLO WORLD', :description => 'Man that was cool')`
3. normal: `GrowlNotify.normal(:title => 'HELLO WORLD', :description => 'Man that was cool')`
4. high: `GrowlNotify.high(:title => 'HELLO WORLD', :description => 'Man that was cool')`
5. emergency: `GrowlNotify.emergency(:title => 'HELLO WORLD', :description => 'Man that was cool')`

#### Sticky messages

`GrowlNotify.sticky!(:title => 'HELLO WORLD', :description => 'Man that was cool')`

#### Options
  
    {:title => 'no title', :application_name => "My Application", :description => 'no description', :sticky => false, :priority => 0, :with_name => "Compass Application", :icon => <file path>}

1. title - Title of message box
2. description - Body of your message
3. icon - Icon to show - pretty much all image formats are supported
4. priority - importance of message from -2 very_low .. 2 emergency
5. sticky - boolean if want the message to stick to the screen
6. application_name - This is set from configs but you can override it
7. with_name - must me one of your set default notifications by default its set to the first one

#### Error Handling

If the growl application is not installed on the system `GrowlNotify` will throw a `GrowlNotFound` exception.

## Author

  GrowlNotify is written by [Scott Davis](http://sdavis.info)
  
  Scott is a Developer for the Space Telescope Science Institute in Baltimore, MD - [Hubble Space Telescope](http://hubblesite.org)
  
  [Twitter](http://twitter.com/jetviper21)

  GrowlNotifyOsascript was hacked together by [Inge Jørgensen](http://elektronaut.no)

## Copyright

Copyright (c) 2011 Scott Davis. See LICENSE.txt for further details.
