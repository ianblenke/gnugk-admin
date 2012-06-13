class Gkconfig < ActiveRecord::Base
  belongs_to :gksection

  validates_uniqueness_of :key, scope: [ :gksection_id ], allow_blank: false, allow_nil: false
  validates_numericality_of :gksection_id, only_integer: true
  validates_associated :gksection
  validates_presence_of :key

  def static_config?
    $GNUGK_STATIC_CONFIG[section] &&
    $GNUGK_STATIC_CONFIG[section][key]
  end

  def self.set section, key, value
    s=Gksection.find_or_create_by_name( section )
    c=Gkconfig.find( :first, conditions: { gksection_id: s.id, key: key } )
    if ! c
      c=Gkconfig.create( gksection_id: s.id, key: key, value: value )
      puts c.errors.message.inspect if ! c.save
    else
      c.value=value
      c.save
    end
  end

  def section
    gksection.name if gksection
  end

  def section= name
    gksection_id=Gksection.find_or_create_by_name(name).id
  end

end
