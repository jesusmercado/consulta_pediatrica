include ModelHelper

class Address < ActiveRecord::Base

  protected :before_validation

  #Relaciones
  belongs_to :patient

  #Validaciones
  validates_presence_of :address
  validates_length_of :address, :maximum => 100, :if => "self.address.present?"

  def to_label
    address
  end

  def before_validation
    sanitizate_strings :address
  end
end
