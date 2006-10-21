require_plugin 'acts_association_helper'

require 'acts_as_phoneable'

ActiveRecord::Base.class_eval do
  include PluginAWeek::Acts::Phoneable
end