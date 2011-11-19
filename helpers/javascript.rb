helpers do
  def js_table(id, cols = 4)
    "$(document).ready(function() {$('#{id}').dataTable({'aoColumnDefs': [
        { 'asSorting': [ 'desc', 'asc' ], 'aTargets': [ #{number_list(cols)} ] },],
      'oLanguage': {'sSearch': 'Filter:'},'bPaginate': false, 'bLengthChange': false, 
      'bInfo': false})});"
  end

  
  def number_list(i)
    str = ''
    i.times {|i| str << "#{i+1},"}
    str
  end
end
