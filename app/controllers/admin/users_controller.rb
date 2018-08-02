class Admin::UsersController < Admin::BaseController
  def update
    @user = User.find_by id: params[:id]
    respond_to do |format|
      case params[:type]
      when Settings.admin.block
        @user&.blocked!
        format.js{render "admin/users/unblock"}
      when Settings.admin.unblock
        @user&.non_block!
        format.js{render "admin/users/block"}
      else
        format.html
      end
    end
  end
end
