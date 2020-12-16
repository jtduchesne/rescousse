module ApplicationHelper
  def navbar_button(*opts)
    content_for(:navbar, render('navbar_button', *opts))
  end
end
