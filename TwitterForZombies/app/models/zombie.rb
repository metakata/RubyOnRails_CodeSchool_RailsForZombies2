class Zombie < ActiveRecord::Base
  has_one :brain, dependent: :destroy
  after_save :decomp_change_notification, if: :decomp_changed?
  
  private
  
  def as_json(options = nil)
    super(options || {include: :brain, except: [:created_at, :updated_at, :id]})
  end
  
  def decomp_change_notification
    ZombieMailer.decomp_change(self).deliver
  end
  
end
