class Calculator < ActiveRecord::Base
  belongs_to :impexpcompany
  belongs_to :manufacturer
end
