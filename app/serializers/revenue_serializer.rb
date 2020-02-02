class RevenueSerializer
  def initialize(revenue, date)
    @revenue = revenue
    @date = date
  end

  def to_json
    { data: {
        attributes: {
          total_revenue: @revenue,
          date: @date
        }
      }
    }
  end
end
