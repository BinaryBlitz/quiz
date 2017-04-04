class Admin::AdminController < ApplicationController
  skip_before_action :restrict_access
  before_action :authenticate_admin!
end
