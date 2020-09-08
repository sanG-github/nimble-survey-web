# frozen_string_literal: true

module ApplicationHelper
  def page_title
    [page_title_prefix, t('shared.page_title')].join(' | ')
  rescue I18n::MissingTranslationData
    t('shared.page_title')
  end

  private

  def page_title_prefix
    return content_for :page_title if content_for?(:page_title)

    t("#{controller_name}.#{action_name}.page_title", raise: true)
  end
end
