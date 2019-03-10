module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instance_storage

    def instances
      instance_storage.size
    end

    private

    attr_writer :instance_storage

    def add_instance_to_storage(inst)
      instance_storage ||= []
      instance_storage << inst
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.send :add_instance_to_storage, self
    end
  end
end
