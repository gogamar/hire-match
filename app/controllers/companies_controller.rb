class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:edit, :update, :published_jobs]

  def edit
    # Ensure user is the owner of the company record
    redirect_to root_path unless @current_company == @company
  end

  def update
    if @current_company.update(company_params)
      redirect_to root_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def published_jobs
    @published_jobs = @current_company.jobs
  end

  private

  def set_company
    @company = Company.find(params[:id])
    authorize @company
  end

  def company_params
    params.require(:company).permit(:name, :user_id)
  end
end
