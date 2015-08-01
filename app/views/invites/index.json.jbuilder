json.array!(@invites) do |invite|
  json.partial! 'invite', invite: invite
end
