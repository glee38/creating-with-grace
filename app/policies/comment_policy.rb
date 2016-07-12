class CommentPolicy < ApplicationPolicy

  def update?
    allowed_roles
  end

  def edit?
    allowed_roles
  end

  def new?
    allowed_roles
  end

  def create?
    allowed_roles || user.try(:persisted?)
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