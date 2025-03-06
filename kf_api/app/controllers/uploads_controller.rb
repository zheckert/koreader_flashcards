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

    flashcards = words.map { |word| current_user.flashcards.find_or_create_by(word: word) }

    # Queue jobs with delays between them
    flashcards.each_with_index do |flashcard, index|
      FetchDefinitionJob.set(wait: index.minutes).perform_later(flashcard.id)
    end

    render json: { 
      message: "File uploaded successfully. Definitions will be fetched over the next #{flashcards.count} minutes.",
      flashcards_count: flashcards.count,
      estimated_completion_time: Time.current + flashcards.count.minutes
    }, status: :created
  end
end