configure do
  set :base_score, 1
  set :super_score, 2
  set :solr_log_file, 'public/logs/searches.csv'
  set :solr, 'search.tki.org.nz:8983'
  set :summary_length, 178
  set :results_length, 5
  set :unique_attempts, 7
  
  set :method_override, false
  set :sessions, true
  set :logging, false # stops annoying double log messages.
  set :static, false # see config.ru for dev mode satatic file serving
end

configure :development do
  set :db, 'sqlite3://' + settings.root + '/db/development.sqlite3'
  set :raise_errors, true
  set :show_exceptions, true
  set :haml, {:format => :html5, :ugly => false }
end

configure :production do
  set :db, 'sqlite3://' + settings.root + '/db/production.sqlite3'
  set :raise_errors, false
  set :show_exceptions, false
  set :haml, {:format => :html5, :ugly => true }
end

# Database; 
# http://datamapper.rubyforge.org/dm-core/DataMapper.html

DataMapper.setup(:default, settings.db)

DataMapper::Property::String.length(255)
DataMapper::Property.required(true)
DataMapper::Logger.new($stdout, :info) if settings.development?

