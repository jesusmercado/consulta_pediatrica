class VaccinesNamesController < ApplicationController
  record_select :per_page => 5,
    :search_on => ['name'],
    :full_text_search => true

  active_scaffold :vaccines_name do |conf|
    conf.columns = :name, :vaccine_schedules
    conf.list.columns.exclude :vaccine_schedules
  end

  def index
    if params[:must_close]
      render :template => "close", :layout => false
    else
      list
    end
  end

end
