class UploadsController < ApplicationController
  # before_action :authenticate_user! todo: uncomment this when we need auth. Currently part of user spoofing

  require 'csv'

  def create
    # Spoof user! todo: remove this and do it right
    @current_user = User.find(1)

    # CHeck and make sure a file is provided
    if params[:file].blank?
      return render json: { error: "No file uploaded" }, status: :unprocessable_entity
    end

    # Attach file to user via ActiveStorage
    current_user.csv_file.attach(params[:file])

    csv_data = current_user.csv_file.download.force_encoding("UTF-8")

    # In case you forget again, headers:true treats the first row as headers instead of data todo: delete this note when you remember
    words = CSV.parse(csv_data, headers: true)
                .map { |row| row["word"] }
                .compact_blank # IN CASE YOU FORGET! This removes nil or blank values. They shouldn't exist at this stage but better to be safe. todo: update or remove note

    flashcards = words.map { |word| current_user.flashcards.create!(word: word) }

    # Queue jobs to grab definitions for each word
    flashcards.each { |flashcard| FetchDefinitionJob.perform_later(flashcard.id) }

    render json: { message: "File uploaded successfully, and definitions are being fetched" }, status: :created
  end
end