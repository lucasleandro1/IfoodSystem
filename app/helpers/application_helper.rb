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
end
