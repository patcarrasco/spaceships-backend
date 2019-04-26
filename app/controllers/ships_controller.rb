class ShipsController < ApplicationController

	def index
		@ships = Ship.all
		#options = {include: [:scores]}
		render json: ShipSerializer.new(@ships)
	end

	def create
		@found = Ship.find_by(email: ship_params[:email])
		if @found
			if (@found.status)
				render json: {error: "You are already logged in"}
				return
			end

			@found.update(status: true)
			render json: ShipSerializer.new(@found)
		else
			@ship = Ship.new(ship_params)
			@ship.x = rand(1..5000)
			@ship.y = rand(1..5000)
	    	if @ship.save
				@score = Score.new(ship: @ship)
				#options = {include: [:scores]}
				render json: ShipSerializer.new(@ship)
	    	end
		end

  	end

	def show
		@ship = Ship.find(params[:id])
		render json: ShipSerializer.new(@ship)
	end

	def update
		@ship = Ship.find(params[:id])
		# if @ship.update.valid?
		# 	MatchChannel.broadcast_to(@ship, )
		# 	render json: ShipSerializer.new(@ship)
		# end
	end

	private

	def ship_params
		params.require(:ship).permit(:email, :name, :color)
	end

end
