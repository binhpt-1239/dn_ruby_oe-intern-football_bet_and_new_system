class CurrenciesController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    moneys = current_user.currencies.search_by_type(params[:type]).newest
    @pagy, @currencies = pagy moneys, items: Settings.digits.digit_6
  end
end
