class BestDaySerializer
  def initialize(date)
    @date = date
  end

  def to_hash
    { data: {
        attributes: {
          best_day: date
        }
      }
    }
  end
end
