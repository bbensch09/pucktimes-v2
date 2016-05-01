class Article < ActiveRecord::Base
  require 'aws-sdk-v1'
  require 'aws-sdk'

  has_attached_file :cover_photo, styles: { large: "600x400>", thumb: "120x80>" }, default_url: "/images/:style/missing.png",
    :storage => :s3,
          :s3_credentials => {
              :bucket => ENV['S3_BUCKET_NAME'],
              :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
              :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
              },
           :bucket => 'puck-times',
           :url => ':s3_domain_url',
           :path => '/:class/:attachment/:id_partition/:style/:filename',
           :s3_host_name => 's3-us-west-1.amazonaws.com'
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\Z/

  # original method for showing days since publish date
  # def time_since_written
  #   time_elapsed = ((Date.today - published) / 1).round
  #     if time_elapsed < 1
  #       return "today."
  #     else
  #       return "#{time_elapsed} days ago."
  #     end
  # end

  def time_since_written
  days_elapsed = ((Time.now - updated_at.to_time) / (60*60*24)).round
  hours_elapsed = ((Time.now - updated_at.to_time) / (60*60)).round
  minutes_elapsed = ((Time.now - updated_at.to_time) / (60)).round
    if minutes_elapsed < 60
      return "#{minutes_elapsed} minutes ago."
    elsif hours_elapsed < 24
      return "#{hours_elapsed} hours ago."
    else
      return "#{days_elapsed} days ago."
    end
end

end
