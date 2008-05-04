module Factory
  # Build actions for the class
  def self.build(klass, &block)
    name = klass.to_s.underscore
    define_method("#{name}_attributes", block)
    
    module_eval <<-end_eval
      def valid_#{name}_attributes(attributes = {})
        #{name}_attributes(attributes)
        attributes
      end
      
      def new_#{name}(attributes = {})
        #{klass}.new(valid_#{name}_attributes(attributes))
      end
      
      def create_#{name}(*args)
        record = new_#{name}(*args)
        record.save!
        record.reload
        record
      end
    end_eval
  end
  
  build Person do |attributes|
    attributes.reverse_merge!(
      :name => 'John Doe'
    )
  end
  
  build PhoneNumber do |attributes|
    attributes[:phoneable] = create_person unless attributes.include?(:phoneable)
    attributes.reverse_merge!(
      :country_code => '1',
      :number => '1234567890'
    )
  end
end
