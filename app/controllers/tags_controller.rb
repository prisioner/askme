class TagsController < ApplicationController
  def show
    @tags = Tag.all
    @tag = Tag.find_by(alias: params[:alias])
    @questions = @tag.questions.order(created_at: :desc)
  end
end
