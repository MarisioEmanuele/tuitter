module ApplicationHelper
  def link_to_user(user)
    link_to user.to_s, "/users/#{user.id}"
  end
end
