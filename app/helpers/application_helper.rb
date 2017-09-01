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
        # ищем точное совпадение (без учета регистра),
        # исключаем частичное включение в другой хэштег
        # #party #partymaker - хэштег #party должен замениться только 1 раз
        words: text.scan(ApplicationRecord::TAG_REGEX).select { |t| tag.name == t.mb_chars.downcase.to_s }
      }
    end

    # Для каждого слова каждой замены заменяем его на ссылку
    # с сохранением оригинального регистра
    replaces.each do |replace|
      replace[:words].each do |word|
        text.gsub!(
          # После слова должен быть символ, который не может быть частью хэштега
          # или конец строки/текста
          /(#{word})([^[:word:]-]|$|\z)/,

          # Заменяем хэштег на ссылку и возвращаем "лишний" символ на место
          link_to('\1', tag_path(replace[:tag]),
                  class: 'tag-link') + '\2'
        )
      end
    end

    text.html_safe
  end

  def city_name(ip)
    Geocoder.configure(language: I18n.locale)
    result = Geocoder.search(ip).first
    lat = result.latitude
    long = result.longitude

    result = Geocoder.search([lat, long]).first

    return if result.nil?

    result.city
  end
end
