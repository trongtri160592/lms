module ApplicationHelper
  def approval_tag(lesson)
    if lesson.approved == 1
      '<span class="label label-success">Đã duyệt</span>'.html_safe
    else
      '<span class="label label-danger">Chưa duyệt</span>'.html_safe
    end
  end

  def course_avatar(model)
    avatar = model.avatar ? model.avatar : 'course_default_logo.jpg'
    image_tag avatar, alt: model.name
  end
end
