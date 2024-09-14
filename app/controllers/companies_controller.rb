class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:edit, :update]

  def edit
    # Ensure user is the owner of the company record
    redirect_to root_path unless current_user.company == @company
  end

  def update
    if @company.update(company_params)
      redirect_to root_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_company
    @company = current_user.company
  end

  def company_params
    params.require(:company).permit(:name)
  end
end
