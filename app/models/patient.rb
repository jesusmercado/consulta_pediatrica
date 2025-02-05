include ModelHelper

class Patient < ActiveRecord::Base
  protected :before_validation

  #Relaciones
  has_many :emails, :dependent => :destroy
  has_many :consultations, :dependent => :destroy
  has_many :family_records, :dependent => :destroy
  has_many :allergies, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :surgical_records, :dependent => :destroy
  has_many :phone_numbers, :dependent => :destroy
  has_many :pathological_records, :dependent => :destroy
  has_many :surgeries, :dependent => :destroy
  has_many :hospitalizations, :dependent => :destroy
  has_many :immunization_records, :dependent => :destroy
  has_one :perinatal_record, :dependent => :destroy
  belongs_to :place
  belongs_to :consultation_price
  has_one :reminder, :as => :reminder, :dependent => :destroy

  #Fotografía
  has_attached_file :photograph, 
    :styles => { :thumbnail => "100x100>" },
    :default_url => "missing.png"

  #Validaciones
  validates_presence_of :first_name, :last_name, :date_of_birth, :place, :consultation_price
  validates_uniqueness_of :first_name, :scope => [:last_name, :date_of_birth], :case_sensitive => false
  validates_length_of :mother, :maximum => 100, :if => "self.mother.presence"
  validates_length_of :father, :maximum => 100, :if => "self.father.presence"
  validates_length_of :first_name, :maximum => 50, :if => "self.first_name.presence"
  validates_length_of :last_name, :maximum => 50, :if => "self.last_name.presence"
  validate :date_of_birth_cant_be_greater_than_today

  def to_label
    name
  end

  def name
    "#{first_name} #{last_name}"
  end

#  def age
#    #    now = Date.today + 1
#    #    birth = self.date_of_birth
#    #    years, months, days = now.diff birth
#    #    age = ""
#    #    unless years.zero?
#    #      age += "#{years} #{as_(years)}"
#    #    end
#    #    unless months.zero?
#    #      age += " " unless age.empty?
#    #      age += "#{months} #{as_(months)}"
#    #    end
#    #    unless days.zero?
#    #      age += " " unless age.empty?
#    #      age += "#{days} #{as_(days)}"
#    #    end
#    #    age
#    distance_of_time_in_words(self.date_of_birth, Date.today)
#  end

  def before_validation
    sanitizate_strings :first_name, :last_name, :mother, :father, :referenced_by
  end

  def clone_patient(patient=self)
    twin = patient.clone
    twin.first_name += " TWIN"
    twin.photograph = nil
    twin.created_at = DateTime.now
    twin.updated_at = DateTime.now
    twin
  end

  def date_of_birth_cant_be_greater_than_today
    unless self.date_of_birth.nil?
      if (self.date_of_birth <=> Date.today) > 0
        errors.add :date_of_birth, "#{as_('can\'t be greater than')} #{as_('today')}"
      end
    end
  end

  def after_initialize
    if @new_record
      self.consultation_price = ConsultationPrice.find_by_default(true) if self.consultation_price.blank?
    end
  end

  def after_create
    self.perinatal_record = PerinatalRecord.new
    self.save
  end

  def amount
    if self.consultation_price.blank?
      nil
    else
      self.consultation_price.amount
    end
  end

  def nearest_birthday?
    how_many_months_should_be_add = (Date.today.year - self.date_of_birth.year) * 12
    birth = self.date_of_birth >> how_many_months_should_be_add
    (((birth >= Date.today - 15) and (birth <= Date.today + 15)) or ((birth >> 12 >= Date.today - 15) and (birth >> 12 <= Date.today + 15)) or ((birth << 12 >= Date.today - 15) and (birth << 12 <= Date.today+ 15)))
  end

  def self.find_birthdays
    Patient.find(:all).map{|p| p.nearest_birthday? ? p:nil}.compact
  end

end
