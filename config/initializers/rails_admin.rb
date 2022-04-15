RailsAdmin.config do |config|
  config.asset_source = :webpacker

  config.main_app_name = Settings.admin_app_name

  config.included_models = %w(SoccerMatch News Comment User Currency UserBet Bet)

  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  config.current_user_method(&:current_user)

  config.authorize_with do
    I18n.locale = params[:locale] || default_locale
    redirect_to main_app.root_path unless current_user.admin?
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except %w(Bet UserBet SoccerMatch)
    end
    export do
      except %w(SoccerMatch)
    end
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
