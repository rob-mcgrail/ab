puts 'Seeding database with initial handlers...'

handler = Handler.first_or_create({ :name => 'Original' }, {
  :name => 'Original',
  :request => 'defType=dismax&qt=standard',
  :created_at => Time.now
})

puts "Creating handler '#{handler.name}'"

handler.save
