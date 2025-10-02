class FoodFilterService
  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    foods = Food.joins(:user)

    @q = foods.ransack(@params[:q])
    filtered_foods = @q.result

    {
      foods: filtered_foods.page(@params[:page]).per(8),
      search: @q,
      restaurants: restaurant_options
    }
  end

  private

  def restaurant_options
    User.joins(:foods)
        .where(role: "restaurante")
        .distinct
        .order(:email)
        .pluck(:id, :email)
        .map { |id, email| [ email.split("@").first.humanize, id ] }
  end
end
