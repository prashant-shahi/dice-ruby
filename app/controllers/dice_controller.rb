class DiceController < ApplicationController
    def roll
        render json: { roll: rand(1..6) }
    end
end
