class ImpexpcompanyIssue < ActiveRecord::Base
  belongs_to :impexpcompany, inverse_of: :impexpcompany_issues
  belongs_to :issue, :impexpcompany_issues
end
