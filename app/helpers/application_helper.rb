module ApplicationHelper

  #todo doesn't work. check it
  def all_questions
    if @cached_question.nil?
      @cached_question = Question.all :order => 'ui_order'
    end
    @cached_question
  end
end
