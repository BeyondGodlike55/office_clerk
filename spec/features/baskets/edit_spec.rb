require 'spec_helper'

describe "edit baskets" do
  before :each do
    sign_in
  end
  it "renders item too" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    td = find(".table").first(".name")
    expect(td).to have_content(basket.items.first.name)
  end
  it "deletes item" do
    basket = create :basket_with_item
    visit_path edit_basket_path(basket)
    name = basket.items.first.name
    within(".table") {  first('a', :text => I18n.t(:delete)).click }
    expect{ find(".table").find(".name" , :minimum => 1) }.to raise_error
    expect(page).not_to have_content(name )
  end
  it "goes to purchase" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    click_on I18n.t(:make_purchase)
    expect(find("h2")).to have_content(I18n.t(:purchase))
  end
  it "finds print link" do
    basket = create :basket_2_items
    visit_path edit_basket_path(basket)
    expect(page).to have_content(I18n.t(:checkout))
    expect(find(".print_order")).to have_content(I18n.t(:checkout))
  end
end
