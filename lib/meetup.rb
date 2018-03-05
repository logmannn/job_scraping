class Store < ActiveRecord::Base
  has_and_belongs_to_many(:brands)
  before_save(:upcase_name)
  validates(:name, presence: true)
  validates(:name, uniqueness: true)
  validates(:name, length: {maximum: 100})

private

  def upcase_name
    self.name  = self.name.capitalize
  end
end
