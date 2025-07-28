module ApplicationHelper
  def split_name(email)
    nome = email.split("@").first
    nome
  end
end
