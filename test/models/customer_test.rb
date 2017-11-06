require "test_helper"

describe Customer do
  let(:customer1) { customers(:one) }

  it "must be valid" do
    value(customer).must_be :valid?
  end
end
