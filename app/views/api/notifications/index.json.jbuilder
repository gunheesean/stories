json.array! @notifications do |notification|
  json.actor notification.actor.username
  json.actor_avatar notification.actor.avatar? ? notification.actor.avatar.url : image_url('/assets/default-avatar.jpg')
  json.action notification.action

  json.type notification.notifiable.class.to_s.underscore.humanize.downcase

  json.url case notification.notifiable.class.to_s
           when "Post" then post_path(notification.notifiable)
           when "User" then user_path(notification.notifiable)
           when "Response" then post_path(notification.notifiable.post, anchor: "response_#{notification.notifiable.id}")
           end
  json.time_ago time_ago_in_words(notification.created_at) + " ago"
  json.unread notification.read_at.nil?
end
