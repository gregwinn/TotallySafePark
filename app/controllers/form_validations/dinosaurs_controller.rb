class FormValidations::DinosaursController < ApplicationController
	before_action :authenticate_user!

	def create
		@dinosaur = Dinosaur.new(dinosaur_params)
		@dinosaur.validate
		respond_to do |format|
			format.text { render partial: "dinosaurs/form", locals: { cage: @dinosaur }, formats: [:html] }
		end
	end

	def update
		@dinosaur = Dinosaur.find(params[:id])
		@dinosaur.assign_attributes(dinosaur_params)
		@dinosaur.validate
		respond_to do |format|
			format.text { render partial: "dinosaurs/form", locals: { cage: @dinosaur }, formats: [:html] }
		end
	end

	private
	def dinosaur_params
		params.require(:dinosaur).permit(:name, :species, :cage_id)
	end
end
