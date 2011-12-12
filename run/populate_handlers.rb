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

handler = Handler.first_or_create({ :name => 'PhrasyTitles' }, {
  :name => 'PhrasyTitles',
  :request => 'defType=dismax&mm=30%&fq=meta_anon_access_b:true AND (url:[* TO *] AND url:http AND -url:cmis.cwa.co.nz AND -url:"http\://admin" AND -url:"http\://www.nzmaths.co.nz" AND -url:.internal. AND -url:.cwa.co.nz AND -url:/Media/Images/ AND -url:/Media/Files/) AND -keyword:waec AND -keyword:moec AND englishstatus:live&pf=title_t^30&qf=title_t^10 keyword.text^10 description_t^5 location_t dc.format dc.right dc.subject topics.all.text contentprovider contentsource strand learningarea keylearningobjective educationalvalue host site institution_name_t url^10 ezf_df_text id&ps=3&qt=standard&bq=url:.nz^10 url:tki^20 dc.right:"Ministry of Education Te Tāhuhu o te Mātauranga"^50',
  :created_at => Time.now
})

puts "Creating handler '#{handler.name}'"

handler.save

handler = Handler.first_or_create({ :name => 'Url' }, {
  :name => 'Url',
  :request => 'defType=dismax&mm=30%&fq=meta_anon_access_b:true AND (url:[* TO *] AND url:http AND -url:cmis.cwa.co.nz AND -url:"http\://admin" AND -url:"http\://www.nzmaths.co.nz" AND -url:.internal. AND -url:.cwa.co.nz AND -url:/Media/Images/ AND -url:/Media/Files/) AND -keyword:waec AND -keyword:moec AND englishstatus:live&ps=3&qf=title_t^10 keyword.text^20 description_t^5 location_t dc.format dc.right dc.subject topics.all.text contentprovider contentsource strand learningarea keylearningobjective educationalvalue host site institution_name_t url^40 ezf_df_text id&pf=title_t^50 ezf_df_text^10 url^20&qt=standard&qs=3&bq=url:tki^30 url:nz^30 dc.right:"Ministry of Education Te Tāhuhu o te Mātauranga"^10',
  :created_at => Time.now
})

puts "Creating handler '#{handler.name}'"

handler.save

handler = Handler.first_or_create({ :name => 'Descripts' }, {
  :name => 'Descripts',
  :request => 'defType=dismax&ps=3&qf=title_t^10 keyword.text^10 description_t^10 location_t dc.format dc.right dc.subject topics.all.text contentprovider contentsource strand learningarea keylearningobjective educationalvalue host site institution_name_t url^40 ezf_df_text id&pf=title_t^10 description_t^20&qt=standard&qs=2&bq=url:tki^20 dc.right:"Ministry of Education Te Tāhuhu o te Mātauranga"^10&mm=30%&fq=meta_anon_access_b:true AND (url:[* TO *] AND url:http AND -url:cmis.cwa.co.nz AND -url:"http\://admin" AND -url:"http\://www.nzmaths.co.nz" AND -url:.internal. AND -url:.cwa.co.nz AND -url:/Media/Images/ AND -url:/Media/Files/) AND -keyword:waec AND -keyword:moec AND englishstatus:live',
  :created_at => Time.now
})

puts "Creating handler '#{handler.name}'"

handler.save

