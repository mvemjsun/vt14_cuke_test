module MyHelpers

    def logged_in?
      return true if session[:user]
      nil
    end

    def is_admin?
      if logged_in?
        if session[:user].admin == true
          return true
        else
          return false
        end
      else
        false
      end
    end

    def link_to(name, location, alternative = false)
      if alternative and alternative[:condition]
        "<a href=#{alternative[:location]}>#{alternative[:name]}</a>"
      else
        "<a href=#{location}>#{name}</a>"
      end
    end

    def random_string(len)
     chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
     str = ""
     1.upto(len) { |i| str << chars[rand(chars.size-1)] }
     return str
    end

    def flash(msg,message_type='error')
      session[:flash] = msg
      if message_type == 'success'
        session[:flash_type] = "alert-success"
      else
        session[:flash_type] = "alert-error"
      end
    end

    def show_flash
      if session[:flash]
        tmp = session[:flash]
        session[:flash] = false
        message=""
        session[:flash_type] = "alert-error" if session[:flash_type].nil?
        if tmp.is_a?(Array)
          tmp.each do |msg|
            message << msg
          end
          "<div class='row alert #{session[:flash_type]}'><b>#{message}</b></div>"
        else
          "<div class='row alert #{session[:flash_type]}'><b>#{tmp}</b></div>"
        end
      end
    end

    def flash_db_error(model)
          tmp = []
          model.errors.messages.keys.each do |key|
            model.errors.messages[key.to_sym].each do |error|

              # Set the messages for the fields
              session[:validation_class][key.to_sym] = "error"
              session[:validation_messages][key.to_sym] = error
              session[:flash] = "The data you have supplied has errors as displayed below. Please correct and re-submit."
              session[:flash_type] = "alert-error"
            end
          end
    end

    # Format to be used later
    def format_gm_time(date_time,time_format=nil)
      if date_time.kind_of?(Time)
        return(date_time.day.to_s + 
               "-" + 
               date_time.mon.to_s + 
               "-" + 
               date_time.year.to_s + 
               " " + 
               date_time.hour.to_s + 
               ":" + 
               date_time.min.to_s + 
               ":" + 
               date_time.sec.to_s)
      else
        nil
      end
    end
end