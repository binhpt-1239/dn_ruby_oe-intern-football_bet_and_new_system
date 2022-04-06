require "rails_helper"
RSpec.describe Comment, type: :model do
  describe "Associations" do
    it {should belong_to(:user)}
    it {should belong_to(:news)}
  end
end
