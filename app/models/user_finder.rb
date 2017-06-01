class UserFinder
  def initialize(location: nil, user: nil)
    @location = location
    @user = user
  end

  def by_company_without_current_user
    user.company.users.where.not(id: user.id)
  end

  def by_location_without(user)
    location.users.where.not(user_locations: { user_id: user.id })
  end

  private

  attr_reader :location, :user
end
