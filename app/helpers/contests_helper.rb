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
end
