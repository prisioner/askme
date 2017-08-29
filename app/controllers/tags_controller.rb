class TagsController < ApplicationController
  def show
    @tags = Tag.all

    # фикс для кириллических тэгов из облака
    tag_alias = params[:alias]
    tag_alias = URI.decode(tag_alias) until tag_alias == URI.decode(tag_alias)

    @tag = Tag.find_by(alias: tag_alias.mb_chars.downcase.to_s)

    @questions = @tag.questions.order(created_at: :desc)
  end
end
