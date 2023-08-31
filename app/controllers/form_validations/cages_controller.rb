class FormValidations::CagesController < ApplicationController
	before_action :authenticate_user!
	def create
		@cage = Cage.new(cage_params)
		@cage.validate
		respond_to do |format|
			format.text { render partial: "cages/form", locals: { cage: @cage }, formats: [:html] }
		end
	end

	def update
		@cage = Cage.find(params[:id])
		@cage.assign_attributes(cage_params)
		@cage.validate
		respond_to do |format|
			format.text { render partial: "cages/form", locals: { cage: @cage }, formats: [:html] }
		end
	end

	private
	def cage_params
		params.require(:cage).permit(:name, :max_capacity, :cage_type)
	end
end
