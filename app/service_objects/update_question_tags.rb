class UpdateQuestionTags
  def call(question, question_params)
    question.update(question_params)
    find_or_create_tags(question_params[:text])
    notify_somebody!
  end

  private

  def notify_somebody!
  end

  def find_or_create_tags(text)
    hashtags = text.scan(TAG_REGEX)
    # answer_hashtags = self.answer.to_s.scan(TAG_REGEX)
    # hashtags = text_hashtags #| answer_hashtags

    self.tags = hashtags.map { |tag| Tag.find_or_create_by(name: tag.mb_chars.downcase.to_s) }
  end
end
  