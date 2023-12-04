class Api::SignUps::Create < ApiAction
  include Api::Auth::SkipRequireAuthToken

  post "/api/sign_ups" do
    user = SignUpUser.create!(params)
    # response with 200 OK with token
    json({token: UserToken.generate(user)})
    # or just response with 201 Created
    # head HTTP::Status::Created
  end
end
