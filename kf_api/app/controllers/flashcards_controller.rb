class FlashcardsController < ApplicationController
  def index
    @flashcards = User.find(1).flashcards.includes(:definition)
    render json: @flashcards, include: :definition
  end

  def destroy
  end
end
