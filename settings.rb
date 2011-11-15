configure :development do
  set :db, 'sqlite3://' + settings.root + '/db/development.sqlite3'
	set :raise_errors, true
  set :show_exceptions, true
  set :static, false
  set :logging, false # stop annoying double log messages.
  set :method_override, true # probably not using this
  # http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html#options
  set :haml, {:format => :html5, :ugly => true }
end

configure :production do
  set :db, 'sqlite3://' + settings.root + '/db/production.sqlite3'
	set :raise_errors, false
  set :show_exceptions, false
  set :static, false
  set :logging, false # stop annoying double log messages.
  set :method_override, true # probably not using this
  set :haml, {:format => :html5, :ugly => true }
end

# Database; 
# http://datamapper.rubyforge.org/dm-core/DataMapper.html

DataMapper.setup(:default, settings.db)

DataMapper::Property::String.length(255)
DataMapper::Property.required(true)
DataMapper::Logger.new($stdout, :info) if settings.development?

