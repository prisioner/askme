module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def user_nickname(user)
    "@#{user.username}"
  end

  def is_current_user?(user)
    current_user.present? && current_user == user
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def user_bg_color(user)
    if user.avatar_bg_color.present?
      user.avatar_bg_color
    else
      "#005a55"
    end
  end

  def user_border_color(user)
    if user.avatar_border_color.present?
      user.avatar_border_color
    else
      "#00b6ad"
    end
  end

  def user_text_color(user)
    if user.profile_text_color.present?
      user.profile_text_color
    else
      "#ffffff"
    end
  end

  def user_header_style(user)
    "background: #{user_bg_color(user)}; color: #{user_text_color(user)}"
  end
end
