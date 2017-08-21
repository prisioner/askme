module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpeg'
    end
  end

  def user_nickname(user)
    "@#{user.username}"
  end

  def questions_count(user)
    user.questions.select(&:persisted?).size
  end

  def is_current_user?(user)
    current_user.present? && current_user == user
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
