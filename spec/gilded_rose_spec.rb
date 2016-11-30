require 'spec_helper'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "quality of an item is never negative" do
      items = [Item.new("foo",1,0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "sell_in reduced by one" do
      items = [Item.new("foo", 1, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
    end

    it "sell_in can be negative" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq -1
    end

  end

end
