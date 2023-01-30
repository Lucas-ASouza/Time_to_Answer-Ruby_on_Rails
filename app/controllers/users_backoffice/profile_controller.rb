class UsersBackoffice::ProfileController < UsersBackofficeController
    before_action :set_user
    before_action :verify_password, only: [:update]

    def edit
        
    end

    def update
        if @user.update(params_user)
            redirect_to users_backoffice_profile_path, notice: "User's data updated with success"
        end    
    end


    private
    
        def set_user
            @user = User.find(current_user.id)
        end

        def params_user
            params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
        end

        def verify_password
            if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
               params[:user].extract!(:password, :password_confirmation)    
            end
        end 
end
