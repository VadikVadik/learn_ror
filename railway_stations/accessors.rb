# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}_history".to_sym) { instance_variable_get(var_history) }
        define_method("#{name}=".to_sym) do |value|
          history = instance_variable_get(var_history)
          instance_variable_set(var_history, []) unless history
          instance_variable_get(var_history).push(value)
          instance_variable_set(var_name, value)
        end
      end
    end

    def strong_attr_accessor(name, class_type)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise "Неверный тип присваемого значения" unless value.instance_of?(class_type)

        instance_variable_set(var_name, value)
      end
    end
  end
end
