class Article < ActiveRecord::Base

  def time_since_written
  ((Time.now - created_at) / 60).round
  end

end
