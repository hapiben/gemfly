class GemfilesController < ApplicationController
  def create
    @gemfile = Gemfile.new(gemfile_params)
    @updated_gemfile = @gemfile.updated_gemfile rescue ''

    respond_to do |format|
      format.js
    end
  end

  def gemfile_params
    params.permit(:gemfile)
  end
end
