module ApplicationHelper

  def full_title(page_title)
    base_title = t('app.title')

    if page_title.empty?
      "#{base_title} | #{t('app.description')}"
    else
      "#{base_title} | #{page_title}"
    end
  end
end
