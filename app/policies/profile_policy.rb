class ProfilePolicy < ApplicationPolicy

  def new?
    allowed_roles
  end

  def create?
    allowed_roles || user.persisted?
  end

  def edit?
    member_allowed
  end

  def update?
    member_allowed
  end

  def destroy?
    allowed_roles
  end

  private

  def allowed_roles
    user.try(:admin?) || user.try(:moderator?)
  end

  def member_allowed
    allowed_roles || record.try(:user) == user
  end

end