require 'page-object'
class SearchResultsPage

	include PageObject

	paragraph(:search_summary, :id => "result_count_text")
	table(:search_results_table, :id => "search_results_table")

	def search_result_count
		cnt = 0
		search_results_table.each do |row|
			cnt = cnt + 1
		end
		return cnt
	end

	def result_first_row
		search_results_table.first_row
	end

	def result_last_row
		search_results_table.last_row
	end

	def search_result_summary
		search_summary
	end

	def result_row(row)
		cnt = row[:row_number]
		return search_results_table_element[cnt+1] if search_results_table_element.count < cnt + 1
		return nil
	end

	def show_details_for(row)
		ref_id = row_cell(row[:row_number].to_i,1)
		class_eval do 
			link(:get_detail_record, :href => "/search/#{ref_id}")
		end
		self.get_detail_record
		return ref_id
	end

	#
	# -- get the data for a specific row and the cell in that row
	#
	def row_cell(table_row,cell_num)
		return search_results_table_element[table_row][cell_num].text if search_results_table_element.count >= table_row.to_i
	end

end