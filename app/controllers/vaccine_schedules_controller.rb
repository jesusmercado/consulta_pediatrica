class VaccineSchedulesController < ApplicationController
  active_scaffold :vaccine_schedule do |conf|
    conf.columns.exclude :number

    conf.columns[:application_type].form_ui = :select
    conf.columns[:application_type].options = {:options => [:dosis, :refuerzo], :include_blank => true}

    conf.columns[:days].options[:format] = nil

    conf.subform.columns = :number, :application_type, :days
  end
end
