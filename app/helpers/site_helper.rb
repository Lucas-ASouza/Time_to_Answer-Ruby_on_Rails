module SiteHelper
    def msg_jubotron
        case params[:action]
        when 'index'
            "Lastest Questions"
        when 'questions'
            "Showing results from \"#{params[:term]}\"..." 
        when 'subject'
            "All questions from \"#{params[:subject]}\"..."     
        end        
    end
end
