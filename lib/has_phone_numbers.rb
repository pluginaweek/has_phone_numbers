module PluginAWeek #:nodoc:
  module Has #:nodoc:
    # Adds base models, with minimal attribute definitions, for interacting with
    # phone numbers.
    module PhoneNumbers
      def self.included(base) #:nodoc:
        base.extend(MacroMethods)
      end
      
      module MacroMethods
        # Creates a new association for having a single phone number.  This
        # takes the same parameters as ActiveRecord::Associations::ClassMethods#has_one.
        # By default, the following associations are the same:
        # 
        #   class Person < ActiveRecord::Base
        #     has_phone_number
        #   end
        # 
        # and
        # 
        #   class Person < ActiveRecord::Base
        #     has_one :phone_number,
        #               :class_name => 'PhoneNumber',
        #               :as => :phoneable,
        #               :dependent => :destroy
        #   end
        def has_phone_number(*args, &extension)
          create_phone_number_association(:one, :phone_number, *args, &extension)
        end
        
        # Creates a new association for having a multiple phone numbers.  This
        # takes the same parameters as ActiveRecord::Associations::ClassMethods#has_many.
        # By default, the following associations are the same:
        # 
        #   class Person < ActiveRecord::Base
        #     has_phone_numbers
        #   end
        # 
        # and
        # 
        #   class Person < ActiveRecord::Base
        #     has_many  :phone_numbers,
        #                 :class_name => 'PhoneNumber',
        #                 :as => :phoneable,
        #                 :dependent => :destroy
        #   end
        def has_phone_numbers(*args, &extension)
          create_phone_number_association(:many, :phone_numbers, *args, &extension)
        end
        
        private
        def create_phone_number_association(cardinality, association_id, *args, &extension)
          options = extract_options_from_args!(args)
          options.symbolize_keys!.reverse_merge!(
            :class_name => 'PhoneNumber',
            :as => :phoneable,
            :dependent => :destroy
          )
          
          send("has_#{cardinality}", args.first || association_id, options, &extension)
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::Has::PhoneNumbers
end
