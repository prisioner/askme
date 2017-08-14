class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Alex',
        username: 'alexklimenkov',
        avatar_url: 'https://secure.gravatar.com/avatar/1bf90aaef27ad96e7ef87738cb9988cd?s=200'
      ),
      User.new(
        id: 2,
        name: 'David',
        username: 'filosof'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @questions = [
      Question.new(text: 'Как дела?', answer: 'Хорошо!', created_at: Date.parse('14.08.2017')),
      Question.new(text: 'Как дела?', answer: 'Хорошо!', created_at: Date.parse('14.08.2017')),
      Question.new(text: 'Как дела?', answer: 'Хорошо!', created_at: Date.parse('14.08.2017')),
      Question.new(text: 'Как дела?', answer: 'Хорошо!', created_at: Date.parse('14.08.2017')),
      Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('14.08.2017')),
      Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('14.08.2017'))
    ]

    @user = User.new(
      username: 'alexklimenkov',
      name: 'Александр',
      avatar_url: 'https://secure.gravatar.com/avatar/1bf90aaef27ad96e7ef87738cb9988cd?s=200',
      questions: @questions
    )

    @new_question = Question.new
  end
end
