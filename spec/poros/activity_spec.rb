require 'rails_helper'

RSpec.describe Activity do
  it 'exists with attributes', :vcr do
    attributes = {
      activity: "Sew a blanket",
      type: "crafting",
      participants: 1,
      price: 0.5
    }
    activity = Activity.new(attributes)

    expect(activity.title).to eq("Sew a blanket")
    expect(activity.type).to eq("crafting")
    expect(activity.participants).to eq(1)
    expect(activity.price).to eq(0.5)
  end
end
