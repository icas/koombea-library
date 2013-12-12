require 'spec_helper'

describe Role do
  it { should have_many(:users) }
  it { should validate_presence_of(:role) }
  it { should validate_uniqueness_of(:role) }
end