json.extract! @proposal, :id, :created_at, :updated_at, :content

json.answers @proposal.answers
