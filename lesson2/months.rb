require 'date'

months = (1..12).each_with_object({}) do |index, memo|
  last_day = Date.new(2018, index, -1)
  month_name = last_day.strftime('%B')
  days_count = last_day.day
  memo[month_name.to_sym] = days_count
end

months.each { |month_name, days_count| puts month_name if days_count == 30 }
