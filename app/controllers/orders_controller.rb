# app/controllers/orders_controller.rb

class OrdersController < ApplicationController
  before_action :authenticate_user!
end
