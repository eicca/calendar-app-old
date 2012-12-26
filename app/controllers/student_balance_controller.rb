class StudentBalanceController < ApplicationController
  load_and_authorize_resource :student
  respond_to :html

  def show
  end

  def edit
  end

  def update
    purchase_params = params[:purchase]
    # FIXME error exception looks weird
    error = @student.purchase(
      purchase_params[:amount].to_i, purchase_params[:credentials])
    if error
      flash.now[:error] = error
      render action: 'edit'
    else
      redirect_to student_balance_path, notice: 'Updated balance successfully'
    end
  end
end
