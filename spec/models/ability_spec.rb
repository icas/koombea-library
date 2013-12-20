require "cancan/matchers"
require 'spec_helper'

# lets remember the roles:
# user: just can search for books and borow them
# admin: manages books, author, loan applications
# root: well, can manage all
describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is an single user" do
      let(:user) do
        Fabricate.build(:user) do
          role { Fabricate.build(:role, account_type: "user") }
        end
      end
      it{ should be_able_to(:read, Book.new) }
      it{ should be_able_to(:read, Author.new) }
      it{ should be_able_to(:read, Editorial.new) }

      it{ should_not be_able_to(:manage, Book.new) }
      it{ should_not be_able_to(:manage, Author.new) }
      it{ should_not be_able_to(:manage, Editorial.new) }
    end

    context "when is an admin user" do
      let(:user) do
        Fabricate.build(:user) do
          role { Fabricate.build(:role, account_type: "admin") }
        end
      end

      it{ should be_able_to(:manage, Book.new) }
      it{ should be_able_to(:manage, Author.new) }
      it{ should be_able_to(:manage, Editorial.new) }
    end

    context "when is an single user" do
      let(:user) do
        Fabricate.build(:user) do
          role { Fabricate.build(:role, account_type: "root") }
        end
      end

      it{ should be_able_to(:manage, :all) }
    end
  end
end