class GemfilesController < ApplicationController
  
  def update
    @gemfile = Gemfile.new(GemParams.build(params))
    @updated_gemfile = @gemfile.updated_gemfile rescue ''

    respond_to do |format|
      format.js
    end
  end

  class GemParams
    def self.build(params)
      params.permit(:gemfile)
    end
  end
end
