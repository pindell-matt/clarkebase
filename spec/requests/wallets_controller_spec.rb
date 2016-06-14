require 'rails_helper'

RSpec.describe Api::V1::WalletsController do
  it "creates a new wallet and generates a new key" do
    user = create(:user)
    login_as user

    expect(user.wallets).to eq []
    expect(user.primary_wallet).to eq nil

    post api_v1_wallets_path, format: :json, wallet_name: "money wife doesn't know about"

    expect(user.wallets.count).to eq 1
    expect(user.primary_wallet).to_not eq nil
    expect(user.primary_wallet.name).to eq "money wife doesn't know about"
  end
end
