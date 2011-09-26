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
end
