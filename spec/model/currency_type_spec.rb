require "rails_helper"
RSpec.describe CurrencyType, type: :model do
  describe "Associations" do
    it {should have_many(:currencies).dependent(:nullify)}
  end
end
