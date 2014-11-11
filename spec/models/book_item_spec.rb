require 'spec_helper'

describe BookItem do

  #Attributes
  it { should have_db_column(:format).of_type(:string) }

  #Associations
  it { should belong_to(:book) }
  it { should belong_to(:user) }

  #Validations
  it {  should validate_presence_of(:book) }
  it {  should validate_presence_of(:user) }
  it {  should validate_presence_of(:format) }
  it {  should ensure_inclusion_of(:format).in_array(['digital', 'paper'])}
end