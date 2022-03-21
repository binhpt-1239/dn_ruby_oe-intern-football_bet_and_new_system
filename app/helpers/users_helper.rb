module UsersHelper
  def gravatar_for user
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "#{Settings.user_url}#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def sum_amount user
    money_add = sum_with_type(user, :payment)
    money_take = sum_with_type(user, :withdrawal)
    money_win = sum_with_type(user, :win)
    money_lose = sum_with_type(user, :lose)
    (money_add + money_win) - (money_take + money_lose)
  end

  private

  def sum_with_type user, type
    user.currencies.search_by_type(type).sum(:amount)
  end
end
