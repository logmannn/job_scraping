class MeetupMember < ActiveRecord::Base
  has_one(:linkedin_user_id)
  validates(:name, uniqueness: true)
end
