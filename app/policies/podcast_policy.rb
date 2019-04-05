class PodcastPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    record.user_id == user.id
  end

  def update?
    show?
  end

  def destroy?
    update?
  end
end
