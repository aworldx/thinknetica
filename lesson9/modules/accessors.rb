module Acсessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attrs)
      attrs.each do |attr|
        attr_name = "@#{attr}".to_sym

        define_method(attr.to_sym) { instance_variable_get(attr_name) }

        define_method("#{attr}=".to_sym) do |val|
          @history ||= {}
          @history[attr.to_sym] ||= []
          @history[attr.to_sym] << instance_variable_get(attr_name)

          instance_variable_set(attr_name, val)
        end

        define_method("#{attr}_history") { @history[attr.to_sym] }
      end
    end

    def strong_attr_accessor(attr, attr_class)
      attr_name = "@#{attr}".to_sym
      define_method(attr.to_sym) { instance_variable_get(attr_name) }

      define_method("#{attr}=".to_sym) do |val|
        if val.class.to_s != attr_class.to_s
          raise "wrong parameter type (#{val.class} instead #{attr_class})"
        end

        instance_variable_set(attr_name, val)
      end
    end
  end
end
