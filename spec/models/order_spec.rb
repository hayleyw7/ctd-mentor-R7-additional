require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do

  describe "get orders_path" do
    it "renders the index view" do
      customer = FactoryBot.create(:customer)
      FactoryBot.create_list(:order, 10, customer: customer)
      get orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "get order_path" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order, customer: customer)
      get order_path(id: order.id)
      expect(response).to render_template(:show)
    end

    it "redirects to the index path if the order id is invalid" do
      get order_path(id: 5000) # an ID that doesn't exist
      expect(response).to redirect_to orders_path
    end
  end

  describe "get new_order_path" do
    it "renders the :new template" do
      get new_order_path
      expect(response).to render_template(:new)
    end
  end

  describe "get edit_order_path" do
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order, customer: customer)
      get edit_order_path(order.id)
      expect(response).to render_template(:edit)
    end
  end

  describe "post orders_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      expect {
        post orders_path, params: { order: order_attributes }
      }.to change(Order, :count).by(1)
      expect(response).to redirect_to order_path(id: Order.last.id)
    end
  end


  describe "post orders_path with invalid data" do
    it "does not save a new entry or redirect" do
      order_attributes = FactoryBot.attributes_for(:order)
      order_attributes.delete(:product_name)
      expect {
        post orders_path, params: { order: order_attributes }
      }.to_not change(Order, :count)
      expect(response).to render_template(:new)
    end
  end

  describe "put order_path with valid data" do
    it "updates and redirects" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order, customer: customer)
      put order_path(order.id), params: { order: { product_count: 5 } }
      expect(order.reload.product_count).to eq(5)
      expect(response).to redirect_to order_path(order.id)
    end
  end

  describe "put order_path with invalid data" do
    it "does not update the order record or redirect" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order, customer: customer)
      put order_path(order.id), params: { order: { product_count: 0 } }
      expect(order.reload.product_count).not_to eq(0)
      expect(response).to render_template(:edit)
    end
  end

  describe "delete an order record" do
    it "deletes an order record" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order, customer: customer)
      expect {
        delete order_path(order.id)
      }.to change(Order, :count).by(-1)
      expect(response).to redirect_to orders_path
    end
  end
end
