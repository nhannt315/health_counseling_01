module ModelSpecHelper
  def email_slug email, id
    "#{email.gsub(/@[a-z\d\-.]+\.[a-z]+\z/, '')} #{id}"
  end

  def medicine_slug name, id
    "#{name} #{id}"
  end
end
