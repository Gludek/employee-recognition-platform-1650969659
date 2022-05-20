module Admins
  class CompanyValuesController < AdminsController
    # GET /company_values
    def index
      @company_values = CompanyValue.all
    end

    def new
      @company_value = CompanyValue.new
    end

    # GET /company_values/1/edit
    def edit
      current_company_value
    end

    # POST /company_values
    def create
      @company_value = CompanyValue.new(company_value_params)

      if @company_value.save
        redirect_to admins_company_values_path, notice: 'Company Value was successfully created.'
      else
        render :new
      end
    end

    # DELETE /company_values/1
    def destroy
      current_company_value
      @company_value.destroy
      redirect_to admins_company_values_url, notice: 'Company Value was successfully destroyed.'
    end

    # PATCH/PUT /company_values/1
    def update
      current_company_value
      if @company_value.update(company_value_params)
        redirect_to admins_company_values_path, notice: 'Company Value was successfully updated.'
      else
        render :edit
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def current_company_value
      @company_value = CompanyValue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
