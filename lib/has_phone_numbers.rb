module PluginAWeek #:nodoc:
  # Adds a generic implementation for dealing with phone numbers
  module HasPhoneNumbers
    module MacroMethods
      # Creates the following association:
      # * +phone_number+ - All phone numbers associated with the current record.
      def has_phone_numbers
        has_many  :phone_numbers,
                    :as => :phoneable
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  extend PluginAWeek::HasPhoneNumbers::MacroMethods
end
