module PageHelper

	def self.click_link_with_text(browser,link_text)
		l = browser.link(:text => link_text)
		l.click if l.exists?
	end

    def self.randomize_data(value)
      case value
      when Array then value[rand(value.size)]
      when Range then rand((value.last+1) - value.first) + value.first
      else value
      end
    end

    #
    # check textbox exits based on either :id or :name
    #
    def self.page_has_textbox(browser,selector)
      selector = selector.symbolize_keys
      element_id = selector[:id] if selector[:id]
      element_name = selector[:name] if selector[:name]

      return browser.text_field(:id => element_id).exists? unless element_id.nil?
      return browser.text_field(:name => element_name).exists? unless element_name.nil?
    end
    
end