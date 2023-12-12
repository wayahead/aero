class Api::Me::Show < ApiAction
  get "/me" do
    json UserSelfSerializer.new(current_user)
  end
end
