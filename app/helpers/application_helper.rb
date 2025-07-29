module ApplicationHelper
  def split_name(email)
    return "Visitante" if email.blank?
    nome = email.split("@").first
    nome.humanize
  end

  def status_badge_class(status)
    case status
    when "pendente"
      "warning"
    when "preparando"
      "info"
    when "em_rota"
      "primary"
    when "entregue"
      "success"
    when "cancelado"
      "danger"
    else
      "secondary"
    end
  end

  # I18n helpers
  def current_locale
    I18n.locale
  end

  def locale_name(locale)
    case locale.to_s
    when "en"
      "English"
    when "pt_br"
      "Português (Brasil)"
    else
      locale.to_s.humanize
    end
  end

  def other_locale
    I18n.locale == :en ? :pt_br : :en
  end
end
