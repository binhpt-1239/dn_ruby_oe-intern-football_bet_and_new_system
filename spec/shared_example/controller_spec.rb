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
