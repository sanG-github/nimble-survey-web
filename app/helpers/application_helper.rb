# frozen_string_literal: true

module ApplicationHelper
  def page_title
    [page_title_prefix, t('page_title.general')].join(' | ')
  rescue I18n::MissingTranslationData
    t('page_title.general')
  end

  private

  def page_title_prefix
    return content_for :page_title if content_for?(:page_title)

    t("page_title.#{controller_name}.#{action_name}", raise: true)
  end
end
