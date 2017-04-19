require 'rails_helper'
RSpec.describe User, type: :model do
    context "with valid attributes" do
        it "should save" do
            expect(build(:user)).to be_valid
        end
    end
end
