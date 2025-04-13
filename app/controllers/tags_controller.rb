class TagsController < ApplicationController
  def autocomplete
    @q = Tag.ransack(name_cont: params[:q])
    @tags = @q.result(distinct: true).limit(10)
      
    render json: @tags.as_json(only: [:id, :name])
  end
end
