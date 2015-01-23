class Admin::AdminController < ApplicationController
  skip_before_filter :restrict_access
  before_action :authenticate_admin!
end
