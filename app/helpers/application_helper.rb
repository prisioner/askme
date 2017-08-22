module ApplicationHelper
  def user_avatar(user)
    user.avatar_url || asset_path('avatar.jpg')
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
    user.avatar_bg_color || "#005a55"
  end

  def user_border_color(user)
    user.avatar_border_color || "#00b6ad"
  end

  def user_text_color(user)
    user.profile_text_color || "#ffffff"
  end

  def user_header_style(user)
    "background: #{user_bg_color(user)}; color: #{user_text_color(user)}"
  end
end
