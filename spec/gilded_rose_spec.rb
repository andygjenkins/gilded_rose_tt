require 'spec_helper'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "reduces quality by one" do
      items = [Item.new("foo", 1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "does not reduce quality below zero" do
      items = [Item.new("foo",1,0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "reduces sell_in by one" do
      items = [Item.new("foo", 1, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
    end

    it "will reduce sell_in below zero" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq -1
    end
  end

  context "Sell by date passed" do
    it "degrades quality twice as fast" do
      items = [Item.new("foo",-1,2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
  end

  context "item is Aged Brie" do
    it "increases in quality as it ages" do
      items = [Item.new("Aged Brie",1,1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end

    it "never has quality higher than 50" do
      items = [Item.new("Aged Brie",1,50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end
  end

  context "item is Sulfuras" do
    it "does not need to be sold" do
      items = [Item.new("Sulfuras, Hand of Ragnaros",0,0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
    end

    it "does not decrease in quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros",0,80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end
  end

  context "item is Backstage Passes" do
    it "increases in quality by 2 when sell_in <= 10 && > 5" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert",10,10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "increases in quality by 3 when sell_in <= 5 && > 0" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert",5,10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 13
    end

    it "reduces quality to zero when sell_in <= 0" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert",0,10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
  end

  context "item is Conjured" do
    it "reduces quality at two times the normal rate" do
      items = [Item.new("Conjured",1,2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
  end
end
