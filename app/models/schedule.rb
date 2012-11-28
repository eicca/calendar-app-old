class Schedule < ActiveRecord::Base
  belongs_to :teacher
  attr_accessible :end_at, :recurring, :start_at, :title

  validates :title, :start_at, :end_at, presence: true

  def as_json(options = {})
    {
      id: id,
      title: title,
      start: start_at.rfc822,
      end: end_at.rfc822,
      recurring: false,
      allDay: false
    }
  end

end
