class DinosaursController < ApplicationController
	skip_before_action :verify_authenticity_token
	acts_as_token_authentication_handler_for User
	before_action :authenticate_user!
	def index
		@dinosaurs = Dinosaur.all
		dinosaur_column_names = Dinosaur.column_names
		matching_keys = params.keys.select { |key| dinosaur_column_names.include?(key) }
		if matching_keys
			@dinosaurs = @dinosaurs.where(matching_keys.map { |key| "#{key} = ?" }.join(" AND "), *matching_keys.map { |key| params[key] })
		end
		respond_to do |format|
			format.html
			format.json { render json: @dinosaurs }
		end
	end

	def new
		@dinosaur = Dinosaur.new
	end

	def create
		@dinosaur = Dinosaur.new(dinosaur_params)
		respond_to do |format|
			if @dinosaur.save
				format.html { redirect_to dinosaurs_path, notice: "Roarrr! A new dino has hatched and is now comfortably chilling in its cage." }
				format.json { render json: @dinosaur, status: :created, location: @dinosaur }
			else
				flash.now[:alert] = "Dr. Hammond failed and the dino could not be hatched."
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @dinosaur.errors, status: :unprocessable_entity }
			end
		end
	end

	def edit
		@dinosaur = Dinosaur.find(params[:id])
	end

	def show
		begin
			@dinosaur = Dinosaur.find(params[:id])
			respond_to do |format|
				format.html
				format.json { render json: @dinosaur }
			end
		rescue ActiveRecord::RecordNotFound
			respond_to do |format|
				format.html { redirect_to dinosaurs_path, alert: "Dinosaur was not found.... is it missing?" }
				format.json { render json: { error: "Dinosaur was not found.... is it missing?" }, status: :not_found }
			end
		end
	end

	def update
		@dinosaur = Dinosaur.find(params[:id])
		respond_to do |format|
			if @dinosaur.update(dinosaur_params)
				format.html { redirect_to dinosaurs_path, notice: "Roarrr! The dino has been hatched... again." }
				format.json { render json: @dinosaur, status: :ok, location: @dinosaur }
			else
				flash.now[:alert] = "Dr. Hammond failed and the dino could not be altered."
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @dinosaur.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@dinosaur = Dinosaur.find(params[:id])
		@dinosaur.destroy
		respond_to do |format|
			format.html { redirect_to dinosaurs_path, notice: "Well, my dear friend, deleting a dinosaur is like erasing a footnote in history." }
			format.json { head :no_content }
		end
	end

	private
	def dinosaur_params
		params.require(:dinosaur).permit(:name, :species, :cage_id)
	end
end
