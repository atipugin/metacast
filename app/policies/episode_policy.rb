class EpisodePolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    record.podcast.user_id == user.id
  end
end
