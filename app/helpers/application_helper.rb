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
end
