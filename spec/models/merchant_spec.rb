require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "Name" do
    expect(subject).to respond_to(:name)
  end
end
