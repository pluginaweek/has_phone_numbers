require 'has_association_helper'

module PluginAWeek #:nodoc:
  module Has #:nodoc:
    module PhoneNumbers #:nodoc:
      def self.included(base) #:nodoc:
        base.extend(MacroMethods)
      end
      
      module MacroMethods
        # 
        def has_phone_number(*args, &extension)
          create_phone_number_association(:one, *args, &extension)
        end
        
        # 
        def has_phone_numbers(*args, &extension)
          create_phone_number_association(:many, *args, &extension)
        end
        
        private
        def create_phone_number_association(count, *args, &extension)
          create_has_association(count, :phone_number, {:as => :phoneable}, *args, &extension)
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::Has::PhoneNumbers
end