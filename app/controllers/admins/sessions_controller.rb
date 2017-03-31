class Admins::SessionsController < Devise::SessionsController
  skip_before_action :restrict_access
end
