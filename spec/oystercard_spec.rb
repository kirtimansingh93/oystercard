require 'oystercard'
describe Oystercard do
  describe ' #balance' do
    # it { is_expected.to respond_to(:balance)}
    it "responds to balance" do
       expect(subject).to respond_to(:balance)
    end
    it 'has a balance of zero'  do
       expect(subject.balance).to eq(0)
    end
  end

  describe ' #top-up' do
    # it { is_expected.to respond_to(:top_up).with(1).argument}
    it "responds to top_up" do
       expect(subject).to respond_to(:top_up).with(1).argument
    end
    it "should top up the balance" do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by(10)
    end
    it "should not exceed balance limit" do
      max_limit = Oystercard::MAX
      subject.top_up(max_limit)
      expect { subject.top_up(1) }.to raise_error ("Maximum limit of #{Oystercard::MAX} pounds")
    end
  end


  describe ' #deduct(amount)' do
    # it { is_expected.to respond_to(:deduct).with(1).argument}
    it "responds to deduct" do
       expect(subject).to respond_to(:deduct).with(1).argument
    end
    it "should reduce the balance by a specified amount" do
      expect{ subject.deduct(10) }.to change{ subject.balance }.by(-10)
    end
  end


  describe ' #touch_in' do
    it { is_expected.to respond_to(:touch_in) }
    it 'touch_in means in journey' do
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end
  end

  describe ' #in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
    it ' is initially not in journey' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe ' #touch_out' do
    it { is_expected.to respond_to(:touch_out) }
    it "touch_out means not in journey" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end

end
