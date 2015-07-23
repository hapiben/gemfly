class GemfilesController < ApplicationController

  def create
    @gemfile = Gemfile.new(GemfileParams.build(params))
    @updated_gemfile = @gemfile.updated_gemfile rescue ''

    respond_to do |format|
      format.js
    end
  end

  class GemfileParams
    def self.build(params)
      params.permit(:gemfile)
    end
  end
end
