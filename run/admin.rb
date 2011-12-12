admin = Admin.first_or_create({ :id => 1 }, {
  :id => 1,
  :password =>ARGV[0].to_hash,
})

puts 'Saving administration password...'

admin.save
