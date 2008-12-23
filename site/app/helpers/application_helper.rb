# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def analytics_tag
    render :partial => "shared/analytics"
  end
end
