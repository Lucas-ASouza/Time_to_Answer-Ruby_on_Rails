class Site::SearchController < SiteController

    def questions


        #@questions = Question.includes(:answers).where(description: params[:term]) 
        #This will only return ocorrunces equal to the :term value

        #@questions = Question.includes(:answers).where("description Like ?", "%#{params[:term]}") 
        #this will only return ocorrunces that start will the :term value

        @questions = Question.includes(:answers)
                             .where("description LIKE ?", "%#{params[:term]}%")
        #this will return ocorrunces that has the :term value anywhere 

    end
end 
