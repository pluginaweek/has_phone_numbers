module PluginAWeek #:nodoc:
  module Acts #:nodoc:
    module Phoneable #:nodoc:
      def self.included(base) #:nodoc:
        base.extend(MacroMethods)
      end
      
      module MacroMethods
        # 
        #
        def acts_as_phoneable(*args, &extension)
          create_options = {
            :foreign_key_name => :phoneable
          }
          default_options = {
            :count => :one
          }
          create_acts_association(:phone_number, create_options, default_options, *args, &extension)
          
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