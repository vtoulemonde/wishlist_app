module ListsHelper

  def admin_list?(list)
    current_user != nil && current_user.id == list.user_id
  end
end
