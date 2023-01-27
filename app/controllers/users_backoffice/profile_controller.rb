class UsersBackoffice::ProfileController < UsersBackofficeController
    before_action :set_user

    def edit
        
    end

    def update
        if @user.update(params_user)
            redirect_to , notice: "User's data updated with success"
    end


    private
    
        def set_user
            @user = User.find(current_user.id)
        end
        def params_user
            params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
        end 
end
