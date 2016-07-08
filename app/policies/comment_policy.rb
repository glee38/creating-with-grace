class CommentPolicy < ApplicationPolicy

  def update?
    allowed_roles
  end

  def create?
    allowed_roles || user.persisted?
  end

  def destroy?
    allowed_roles
  end

  private

  def allowed_roles
    user.admin? || user.moderator? || record.try(:commenter) == user
  end

end