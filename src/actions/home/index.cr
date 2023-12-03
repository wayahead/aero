class Home::Index < ApiAction
  include Api::Auth::SkipRequireAuthToken

  get "/" do
    json({message: "Hello"})
  end
end
