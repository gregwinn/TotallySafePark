class CagesController < ApplicationController
    skip_before_action :verify_authenticity_token
    acts_as_token_authentication_handler_for User
    before_action :authenticate_user!
    load_and_authorize_resource
    def index
        @cages = Cage.all
        cage_column_names = Cage.column_names
        matching_keys = params.keys.select { |key| cage_column_names.include?(key) }
        if matching_keys
            @cages = @cages.where(matching_keys.map { |key| "#{key} = ?" }.join(" AND "), *matching_keys.map { |key| params[key] })
        end
        respond_to do |format|
	        format.html
			format.json { render json: @cages }
        end
    end

    def show
        begin
            @cage = Cage.find(params[:id])
            @dinosaurs = @cage.dinosaurs
            respond_to do |format|
                format.html
                format.json { render json: @cage }
            end
        rescue ActiveRecord::RecordNotFound
            respond_to do |format|
                format.html { redirect_to cages_path, alert: "Cage not found." }
                format.json { render json: { error: "Cage not found." }, status: :not_found }
            end
        end
    end

    def new
        @cage = Cage.new
    end

    def create
        @cage = Cage.new(cage_params)
        respond_to do |format|
            if @cage.save
                format.html { redirect_to cages_path, notice: "Cage was successfully created. Welcome to Jurassic Park!" }
                format.json { render json: @cage, status: :created, location: @cage }
            else
                format.html { render :new, status: :unprocessable_entity, alert: "Cage could not be created."}
                format.json { render json: @cage.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
        @cage = Cage.find(params[:id])
    end

    def update
        @cage = Cage.find(params[:id])
        @cage.update(cage_params)
        respond_to do |format|
            if @cage.save
                format.html { redirect_to cages_path, notice: "Cage was successfully updated." }
                format.json { render json: @cage, status: :ok, location: @cage }
            else
                format.html { render :edit, status: :unprocessable_entity, alert: "Cage could not be updated."}
                format.json { render json: @cage.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @cage = Cage.find(params[:id])
        respond_to do |format|
            if @cage.destroy
                format.html { redirect_to cages_path, notice: "Cage has been torn down." }
                format.json { head :no_content }
            else
                format.html { redirect_to cages_path, alert: "Hey! You have dinosaurs in this cage, you can't let them out!" }
                format.json { render json: @cage.errors, status: :unprocessable_entity }
            end
        end
    end

    private
    def cage_params
        params.require(:cage).permit(:name, :max_capacity, :cage_type, :power)
    end
end
