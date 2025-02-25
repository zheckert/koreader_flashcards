class UploadsController < ApplicationController
  # before_action :authenticate_user! todo: uncomment this when we need auth

  def create
    puts current_user.inspect
    # CHeck and make sure a file is provided
    if params[:file].blank?
      return render json: { error: "No file uploaded" }, status: :unprocessable_entity
    end

    # Attach file to user via ActiveStorage
    current_user.csv_file.attach(params[:file])

    render json: { message: "File uploaded successfully" }, status: :created
  end
end