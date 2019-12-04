class GoodIssueFile < ActiveRecord::Base
  belongs_to :issue, inverse_of: :good_issue_files

  mount_uploader :file, GoodIssueUploader
end
