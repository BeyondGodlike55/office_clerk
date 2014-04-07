require 'spec_helper'

describe "Basket buttons" do
  before(:each) do 
    sign_in
    visit_path new_basket_path
  end
  it "shold have back and update buttons" do
    page.should have_content I18n.t(:back)
    find_button I18n.t("helpers.submit.update" , :model => I18n.t(:basket))
    find_link I18n.t(:new) + ' ' + I18n.t(:basket)
    find_link I18n.t(:destroy)
  end
  it "adds product" do
    ean = "123456Z"
    p = create :product , :ean => ean
    within ".ean_form" do
      fill_in "ean" , :with => "#{ean}"
      click_on I18n.t(:search)
    end
    td = find(".table").find(".name")
    td.should have_content(p.name)
  end
  it "creates a new order" do
    visit_path new_basket_path
    ean = "123456Z"
    p = create :product , :ean => ean
    within ".ean_form" do
      fill_in "ean" , :with => "#{ean}"
      click_on I18n.t(:search)
    end
    url = page.current_path
    page.should_not have_content I18n.t(:to_order)
    click_link I18n.t(:print)
    page.should have_content I18n.t(:order)
  end
end