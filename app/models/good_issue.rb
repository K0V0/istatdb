class GoodIssue < ActiveRecord::Base
  belongs_to :good, inverse_of: :good_issues
  belongs_to :issue, inverse_of: :good_issues
  belongs_to :impexpcompany, inverse_of: :good_issues
end
