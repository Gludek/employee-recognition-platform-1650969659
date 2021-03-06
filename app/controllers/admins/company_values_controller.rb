module Admins
  class CompanyValuesController < AdminsController
    def index
      render :index, locals: { company_values: CompanyValue.all }
    end

    def new
      render :new, locals: { company_value: CompanyValue.new }
    end

    def edit
      render :edit, locals: { company_value: company_value }
    end

    def create
      @company_value = CompanyValue.new(company_value_params)

      if company_value.save
        redirect_to admins_company_values_path, notice: 'Company Value was successfully created.'
      else
        render :new, locals: { company_value: company_value }
      end
    end

    def destroy
      company_value.destroy
      redirect_to admins_company_values_url, notice: 'Company Value was successfully destroyed.'
    end

    def update
      if company_value.update(company_value_params)
        redirect_to admins_company_values_path, notice: 'Company Value was successfully updated.'
      else
        render :edit, locals: { company_value: company_value }
      end
    end

    private

    def company_value
      @company_value ||= CompanyValue.find(params[:id])
    end

    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
