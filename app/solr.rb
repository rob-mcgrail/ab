class Solr
  require 'open-uri'
  require 'ostruct'

	def self.search(q='', opts={})
	  default = {
	    :limit => settings.results_length,
	    :handler => 'qt=' + settings.default_handler
	  }
	  limit = opts[:limit] || default[:limit]
	  handler = opts[:handler] || default[:handler]
	  solr = self.new
	  results = solr.search(q, limit, handler)
	end
	

  def self.ab_search(q, handler_pair)
    results = {}
    handler_pair.each do |k,v|
      results[k] = {:handler => v.id, :items=> Solr.search(q, :handler => v.request)}
    end
    results
  end
	
	
	def initialize
	  @xpaths = settings.record_hash
	end


	def search(q, limit, handler=nil)
		query = "http://#{settings.solr}/solr/select?q=#{q}&rows=#{limit}&#{handler}"
		begin
			raw_results = Nokogiri::XML(open(URI.encode(query)))
		rescue SystemCallError, EOFError
			retry
		end
		results = []
		raw_results.xpath('//doc').each do |doc|
			doc = Nokogiri::XML.parse(doc.to_s) # confused... inefficient...
			item = OpenStruct.new
      @xpaths.each do |k,v|
        item.send("#{k}=", doc.xpath(v).text)
      end
			results << tidy_result(item)
		end
		results
	end
	
	
	def tidy_result(item)
	  item.summary = item.body + item.description + item.ezf
	  if item.summary.length > settings.summary_length
	    item.summary = item.summary[0..settings.summary_length]
	    item.summary << '...'
	  end
	  item
	end
end
