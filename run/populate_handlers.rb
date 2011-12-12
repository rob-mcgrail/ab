puts 'Seeding database with initial handlers...'

handler = Handler.first_or_create({ :name => 'Original' }, {
  :name => 'Original',
  :request => 'defType=dismax&qt=standard&bq=url:.nz^10 dc.right:"Ministry of Education Te Tāhuhu o te Mātauranga"^100&fq=meta_anon_access_b:true AND (url:[* TO *] AND url:http AND -url:cmis.cwa.co.nz AND -url:"http\://admin" AND -url:"http\://www.nzmaths.co.nz" AND -url:.internal. AND -url:.cwa.co.nz AND -url:/Media/Images/ AND -url:/Media/Files/) AND -keyword:waec AND -keyword:moec AND englishstatus:live&qf=title_t^10 keyword.text^7 description_t^5 location_t dc.format dc.right dc.subject topics.all.text contentprovider contentsource strand learningarea keylearningobjective educationalvalue host site institution_name_t url ezf_df_text id',
  :created_at => Time.now
})

puts "Creating handler '#{handler.name}'"

handler.save

handler = Handler.first_or_create({ :name => 'BareBones' }, {
  :name => 'BareBones',
  :request => 'defType=dismax&qt=standard&fq=meta_anon_access_b:true AND (url:[* TO *] AND url:http AND -url:cmis.cwa.co.nz AND -url:"http\://admin" AND -url:"http\://www.nzmaths.co.nz" AND -url:.internal. AND -url:.cwa.co.nz AND -url:/Media/Images/ AND -url:/Media/Files/) AND -keyword:waec AND -keyword:moec AND englishstatus:live&qf=ezf_df_text id',
  :created_at => Time.now
})

puts "Creating handler '#{handler.name}'"

handler.save







