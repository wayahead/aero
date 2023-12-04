class Api::Me::Show < ApiAction
  get "/me" do
    json UserSerializer.new(current_user)
  end
end
