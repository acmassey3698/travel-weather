class Activity
  attr_reader :title,
              :type,
              :participants,
              :price

  def initialize(attrs)
    @title        = attrs[:activity]
    @type         = attrs[:type]
    @participants = attrs[:participants]
    @price        = attrs[:price]
  end
end
