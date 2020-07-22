# frozen_string_literal: true

class ApplicationModel
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serializers::JSON
  include Associations

  class << self
    def attribute_keys
      @attribute_keys ||= new.attributes.keys.map(&:to_sym)
    end
  end

  def initialize(attributes = {})
    if attributes.present?
      attributes = attributes.deep_transform_keys(&:to_sym)
      super(attributes.slice(*self.class.attribute_keys - self.class.associations.keys))

      assign_associations(attributes)
    else
      super(attributes)
    end
  end

  def attributes
    super.deep_transform_keys(&:to_sym)
  end
end
