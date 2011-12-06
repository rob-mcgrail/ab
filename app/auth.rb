class Admin
  include DataMapper::Resource
  property :id,         Serial # primary serial key
  property :password,   String,  :required => true,  :length => 64

  def self.authenticate(p)
    admin = Admin.get(1)
    if admin.nil?
      return nil
    else
      if admin.password.make_matchable == p
        return admin
      else
        return nil
      end
    end
  end
end


Warden::Strategies.add(:password) do
  def valid?
    params['password']
  end

  def authenticate!
    admin = Admin.authenticate(params['password'])
    unless admin.nil?
      success!(admin)
    else
      fail!
    end
  end
end


Warden::Manager.serialize_into_session do |admin|
  admin.id
end


Warden::Manager.serialize_from_session do |id|
  Admin.get(id)
end


helpers do
  def authorize!(failure_path=nil)
    unless env['warden'].authenticated?
      flash[:error] = error_text[:needs_password]
      redirect failure_path || '/unauthenticated'
    end
  end
end


get '/unauthenticated/?' do
  status 401
  flash[:error] = error_text[:needs_password]
  redirect '/'
end


post '/unauthenticated/?' do
  status 401
  flash[:error] = error_text[:invalid_password]
  redirect '/'
end


get '/login/?' do
  haml :'warden/login'
end


get '/logout/?' do
  authorize!
  env['warden'].logout
  flash[:success] = success_text[:logged_out]
  redirect '/'
end


post '/login/?' do
  env['warden'].authenticate!(:password)
  flash[:success] = success_text[:logged_in]
  redirect '/'
end


