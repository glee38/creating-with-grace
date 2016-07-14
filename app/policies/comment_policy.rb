class CommentPolicy < ApplicationPolicy

  def update?
    member_allowed
  end

  def edit?
    member_allowed
  end

  def new?
    allowed_roles
  end

  def create?
    allowed_roles || user.try(:persisted?)
  end

  def destroy?
    member_allowed
  end

  private

  def allowed_roles
    user.try(:admin?) || user.try(:moderator?)
  end

  def member_allowed
    allowed_roles || record.try(:commenter) == user
  end

end