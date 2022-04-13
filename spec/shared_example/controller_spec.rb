RSpec.shared_examples "when not logged in" do |action|
  before {get action}

  it_behaves_like "flash danger message", "notification.log_in.request"
  it_behaves_like "redirect to path", "login_path"
end

RSpec.shared_examples "when not logged in admin" do
  before {get :index}

  it_behaves_like "flash danger message", "base.request_login"
  it_behaves_like "redirect to path", "root_path"
end

RSpec.shared_examples "when do not have access" do |action|
  before {get action}

  it_behaves_like "redirect to path", "root_path"
end

RSpec.shared_examples "when admin not logged in" do |action|
  before {get action}

  it_behaves_like "flash danger message", "base.request_login"
  it_behaves_like "redirect to path", "root_path"
end

RSpec.shared_examples "when logged in but not admin" do |action|
  let!(:client_user) { create(:client_user)}
  before do
    log_in client_user
    get action
  end

  it_behaves_like "flash danger message", "base.not_allow"
  it_behaves_like "redirect to path", "root_path"
end

RSpec.shared_examples "render action template" do |action|
  it "render #{action} template" do
    expect(response).to render_template action
  end
end

RSpec.shared_examples "flash warning message" do |message|
  it "flash warning" do
    expect(flash[:warning]).to eq I18n.t(message, default: message)
  end
end

RSpec.shared_examples "flash danger message" do |message|
  it "flash danger" do
    expect(flash[:danger]).to eq I18n.t(message, default: message)
  end
end

RSpec.shared_examples "flash now danger message" do |message|
  it "flash danger" do
    expect(flash.now[:danger]).to eq I18n.t(message, default: message)
  end
end

RSpec.shared_examples "flash success message" do |message|
  it "flash success" do
    expect(flash[:success]).to eq I18n.t(message, default: message)
  end
end

RSpec.shared_examples "redirect to path" do |path|
  it "redirect to #{path}" do
    expect(response).to redirect_to public_send(path)
  end
end

RSpec.shared_examples "#load_teams_and_tournaments" do
  it_behaves_like "should load teams"
  it_behaves_like "should load tournaments"
end

RSpec.shared_examples "should load teams" do
  it "load teams" do
    teams = Team.all
    expect(assigns(:teams)).to eq teams
  end
end

RSpec.shared_examples "should load tournaments" do
  it "load tournaments" do
    tournaments = Tournament.all
    expect(assigns(:tournaments)).to eq tournaments
  end
end

RSpec.shared_examples "has soccer match" do
  it "load soccer match" do
    expect(assigns(:soccer_match)).to eq soccer_match
  end
end

RSpec.shared_examples "has no soccer match" do |http_method, link|
    before do
      send(http_method, link.to_sym, params: { id: -1})
    end
    it_behaves_like "flash danger message", "admin.soccer_matches.not_found_match"
    it_behaves_like "redirect to path", "admin_root_path"
end
