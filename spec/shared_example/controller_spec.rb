RSpec.shared_examples "when not logged in" do |action|
  before {get action}

  it_behaves_like "flash danger message", "notification.log_in.request"
  it_behaves_like "redirect to path", "login_path"
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
