class Visit < ActiveRecord::Base
  belongs_to :link
  validates_presence_of :ip_address, :browser_name, :os
end
