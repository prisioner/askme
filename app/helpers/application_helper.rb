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

  def fill_text_with_tag_links(text, tags)
    # Сохраняем оригинальный регистр текста
    # {
    #   tag: 'hashtag'
    #   words: ['#Hashtag', '#hashTag', '#HASHTAG']
    # }
    replaces = tags.map do |tag|
      {
        tag: tag.alias,
        words: text.scan(/#{tag.name}/i)
      }
    end

    # Для каждого слова каждой замены заменяем его на ссылку
    # с сохранением оригинального регистра
    replaces.each do |replace|
      replace[:words].each do |word|
        text.gsub!(
          word,
          link_to(word, tag_path(replace[:tag]), class: 'tag-link')
        )
      end
    end

    text.html_safe
  end
end
