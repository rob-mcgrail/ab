configure :development do
  set :db, 'sqlite3://' + settings.root + '/db/development.sqlite3'
  set :raise_errors, true
  set :show_exceptions, true
  set :static, false
  set :logging, false # stops annoying double log messages.
  set :method_override, true # probably not using this
  set :sessions, true
  set :haml, {:format => :html5, :ugly => false }
  set :solr_log_file, 'public/log/searches.csv'
  set :base_score, 1
  set :super_score, 2
end

configure :production do
  set :db, 'sqlite3://' + settings.root + '/db/production.sqlite3'
  set :raise_errors, false
  set :show_exceptions, false
  set :static, false
  set :logging, false # stops annoying double log messages.
  set :method_override, true # probably not using this
  set :sessions, true
  set :haml, {:format => :html5, :ugly => true }
  set :solr_log_file, 'public/log/searches.csv'
  set :base_score, 1
  set :super_score, 2
end

# Database; 
# http://datamapper.rubyforge.org/dm-core/DataMapper.html

DataMapper.setup(:default, settings.db)

DataMapper::Property::String.length(255)
DataMapper::Property.required(true)
DataMapper::Logger.new($stdout, :info) if settings.development?

