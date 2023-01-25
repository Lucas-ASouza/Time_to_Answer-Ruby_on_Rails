class Site::SearchController < SiteController

    def questions
        params[:term]
        @questions = Question.includes(:answers).page(params[:page]).per(5)
    end
end 
