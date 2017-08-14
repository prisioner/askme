module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpeg'
    end
  end

  def user_questions_count(user)
    one = "вопрос"
    few = "вопроса"
    many = "вопросов"
    count = user.questions.size

    declension(count, one, few, many, true)
  end

  def declension(count, one, few, many, with_count = false)
    prefix = with_count ? "#{count} " : ""

    count = count.to_i

    # Берём остаток от деления на 100
    ostatok = count % 100
    # Если мы попали в 20..99 - нас интересует только последняя цифра
    ostatok = ostatok % 10 if ostatok > 20

    case ostatok
    when 1 then "#{prefix}#{one}"
    when 2..4 then "#{prefix}#{few}"
    else
      "#{prefix}#{many}"
    end
  end
end
