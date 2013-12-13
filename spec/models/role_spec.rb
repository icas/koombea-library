require 'spec_helper'

describe Role do
  it { should have_many(:users) }
  it { should validate_presence_of(:account_type) }
  it { should validate_uniqueness_of(:account_type) }
end