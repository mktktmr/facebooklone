module ApplicationHelper
  def profile_img(user, options = {})
    options.merge alt: user.name
    return image_tag(user.avatar, options) if user.avatar?

    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, options)
  end
end
