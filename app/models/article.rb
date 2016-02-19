class Article < ActiveRecord::Base
  has_attached_file :cover_photo, styles: { medium: "400x400>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\Z/

  def time_since_written
    time_elapsed = ((Date.today - published) / 1).round
      if time_elapsed < 1
        return "today."
      else
        return "#{time_elapsed} days ago."
      end
  end

end
