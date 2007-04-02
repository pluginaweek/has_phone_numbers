require 'acts_association_helper'

module PluginAWeek #:nodoc:
  module Acts #:nodoc:
    module Phoneable #:nodoc:
      def self.included(base) #:nodoc:
        base.extend(MacroMethods)
      end
      
      module MacroMethods
        # 
        def acts_as_phoneable(*args, &extension)
          default_options = {
            :as => :phoneable,
            :count => :one
          }
          create_acts_association(:phone_number, default_options, *args, &extension)
          
          extend PluginAWeek::Acts::Phoneable::ClassMethods
          include PluginAWeek::Acts::Phoneable::InstanceMethods
        end
      end
      
      module ClassMethods #:nodoc:
      end
      
      module InstanceMethods #:nodoc:
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::Acts::Phoneable
end