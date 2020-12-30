class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def self.human_enum_name(name, value, options = {})
    name = name.to_s.pluralize
    
    defaults = lookup_ancestors.map do |klass|
      :"#{i18n_scope}.attributes.#{klass.model_name.i18n_key}.#{name}.#{value}"
    end
    
    defaults << :"attributes.#{name}.#{value}"
    defaults << options.delete(:default) if options[:default]
    defaults << value.humanize
    
    options[:default] = defaults
    I18n.translate(defaults.shift, **options)
  end
end
