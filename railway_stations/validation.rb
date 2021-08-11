# frozen_string_literal: true

module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def validate(name, validation_type, param = nil)
      @validations ||= []
      @validations << { name: name, validation_type: validation_type, param: param }
    end

    def run(name, validation_type, attr, param = nil)
      errors = []
      case validation_type
      when :presence
        errors << "Значение атрибута @#{name} не может быть nil" if attr.nil?
        errors << "Значение атрибута @#{name} не может быть пустой строкой" if attr == ""
      when :format
        errors << "Неверный формат атрибута @#{name}: #{attr}" if attr !~ param
      when :type
        errors << "Неверный класс атрибута @#{name}: #{attr.class}, ожидается: #{param}" if attr.class != param
      end
      raise errors.join(". ") unless errors.empty?
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate!
      correct_class = self.class.superclass != Object ? self.class.superclass : self.class
      correct_class.instance_variable_get(:@validations).each do |validation|
        attr = instance_variable_get("@#{validation[:name]}".to_sym)
        self.class.run(validation[:name], validation[:validation_type], attr, validation[:param])
      end
    end
  end
end
