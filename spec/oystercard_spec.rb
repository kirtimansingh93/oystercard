require 'oystercard'
describe Oystercard do
  let (:card) {Oystercard.new}
  let (:entry_station) {double :station}
  let (:exit_station) {double :station}
  describe ' #balance' do
    # it { is_expected.to respond_to(:balance)}
    it "responds to balance" do
       expect(card).to respond_to(:balance)
    end
    it 'has a balance of zero'  do
       expect(card.balance).to eq(0)
    end
  end

  describe ' #top-up' do
    # it { is_expected.to respond_to(:top_up).with(1).argument}
    it "responds to top_up" do
       expect(card).to respond_to(:top_up).with(1).argument
    end
    it "should top up the balance" do
      expect{ card.top_up(10) }.to change{ card.balance }.by(10)
    end
    it "should not exceed balance limit" do
      max_limit = Oystercard::MAX
      card.top_up(max_limit)
      expect { card.top_up(1) }.to raise_error ("Maximum limit of #{Oystercard::MAX} pounds")
    end
  end


  describe ' #deduct(amount)' do
    # it { is_expected.to respond_to(:deduct).with(1).argument}
    it "responds to deduct" do
       expect(card).to respond_to(:deduct).with(1).argument
    end
    it "should reduce the balance by a specified amount" do
      expect{ card.deduct(10) }.to change{ card.balance }.by(-10)
    end
  end


  describe ' #touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it 'touch_in means in journey' do
      card.top_up(Oystercard::MAX)
      card.touch_in(entry_station)
      expect(card.in_journey?).to eq true
    end
    it "raises an error if balance is below minimum" do
    expect { card.touch_in(entry_station) }.to raise_error ("balance below minimum")
    end
    it "should show the entry station" do
      card.top_up(Oystercard::MAX)
      card.touch_in(entry_station)
      expect(card.entry_station ).to eq entry_station
    end
  end

  describe ' #in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
    it ' is initially not in journey' do
      expect(card.in_journey?).to eq false
    end
  end

  describe ' #touch_out' do
    it { is_expected.to respond_to(:touch_out) }
    it "touch_out means not in journey" do
      card.top_up(Oystercard::MAX)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.in_journey?).to eq false
    end
    it "deducts an amount when you touch_out" do
      card.top_up(Oystercard::MAX)
      card.touch_in(entry_station)
      expect { card.touch_out(exit_station) }.to change { card.balance }.by(-Oystercard::MIN)
    end
    it "sets entry_station to nil" do
      card.top_up(Oystercard::MAX)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect( card.entry_station ).to eq nil
    end
    it "should show the exit station" do
      card.top_up(Oystercard::MAX)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.exit_station ).to eq exit_station
    end
  end
  # describe " #journeys" do
  #   it "should show all my journeys" do
  #     expect(card.journeys).to eq{}
  #   end
  # end


end
