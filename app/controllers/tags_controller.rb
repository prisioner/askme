class TagsController < ApplicationController
  def show
    @tags = Tag.all

    # фикс для кириллических тэгов из облака
    tag_alias = params[:alias]
    tag_alias = URI.decode(tag_alias) until tag_alias == URI.decode(tag_alias)

    @tag = Tag.find_by(alias: tag_alias.mb_chars.downcase.to_s)

    @questions = @tag.questions.order(created_at: :desc)

    # собираем список вопросов от похожих хэштегов
    linked_tags_all_questions =
        @tag.
            linked_tags.
            flat_map(&:questions).
            uniq.
            sort_by { |q| q.created_at }.
            reverse

    # Убираем повторы
    @linked_tags_questions = linked_tags_all_questions - @questions.to_a
  end
end
