module ApplicationHelper
  def split_name(email)
    nome = email.split("@").first
    nome
  end

  def status_color(status)
    case status
    when 'pendente'
      '#ffc107'
    when 'preparando'
      '#fd7e14'
    when 'em_rota'
      '#0dcaf0'
    when 'entregue'
      '#198754'
    when 'cancelado'
      '#dc3545'
    else
      '#6c757d'
    end
  end
end
