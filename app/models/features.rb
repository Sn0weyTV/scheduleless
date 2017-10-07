class Features
  def self.for(company)
    new(company: company)
  end

  def initialize(company:)
    @company = company
  end

  def time_clock?
    PlanFeature.
      joins(:feature).
      where(plan_id: plan_id, features: { key: "time_clock"}).
      exists?
  end

  def trading?
    PlanFeature.
      joins(:feature).
      where(plan_id: plan_id, features: { key: "trading"}).
      exists?
  end

  def wages?
    PlanFeature.
      joins(:feature).
      where(plan_id: plan_id, features: { key: "wages"}).
      exists?
  end

  private

  attr_reader :company

  def plan_id
    subscription.plan_id
  end

  def subscription
    company.subscription
  end
end
