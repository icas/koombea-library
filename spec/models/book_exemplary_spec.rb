require 'spec_helper'

describe BookExemplary do
  subject{BookExemplary.new}

  #Attributes
  it{should respond_to(:book_id, :owner_id)}

  #Associations
  it{should belong_to(:book)}
  it{should belong_to(:owner)}
end
