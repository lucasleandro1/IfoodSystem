module PeriodFilterHelper
  def self.apply_period_filter(relation, period)
    case period
    when "today"
      relation.where(requested_at: Date.current.beginning_of_day..Date.current.end_of_day)
    when "week"
      relation.where(requested_at: 1.week.ago.beginning_of_day..Time.current)
    when "month"
      relation.where(requested_at: 1.month.ago.beginning_of_day..Time.current)
    else
      relation
    end
  end
end
