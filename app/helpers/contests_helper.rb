module ContestsHelper
  def format_time(some_time)
    "%d:%.2d" % [some_time / 60, some_time % 60]
  end
  
  def format_time_left(contest)
    if contest.running?
      format_time(contest.time_left)
    elsif contest.finished?
      "Contest finished"
    else
      "Contest starts in " + format_time(contest.time_to_start)
    end
  end
  
  def format_time_of_first_solution(time)
    time.blank? ? "--" : time.round
  end
  
  def format_tries(team, problem)
    if @contest.problem_solved?(team, problem)
      @contest.wrong_tries_before_solution(team, problem) + 1
    else
      t = @contest.wrong_tries_before_solution(team, problem)
      t == 0 ? "--" : t
    end
  end
  
  def class_for_problem(team, problem)
    if @contest.problem_solved?(team, problem)
      "green"
    elsif @contest.wrong_tries_before_solution(team, problem) > 0
       "red"
    else
      "normal"
    end
  end
  
  def contest_status(contest)
    css_class, text = if contest.running?
      ["running", "Running"]
    elsif contest.finished?
      ["finished", "Finished"]
    else
      ["upcoming", "Upcoming"]
    end
    content_tag(:span, text, :class => css_class)
  end
end
