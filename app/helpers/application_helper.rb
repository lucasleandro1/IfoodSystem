module ApplicationHelper
  def split_name(email)
    nome = email.split("@").first
    nome
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
