require 'oystercard'
describe Oystercard do
  describe '#balance' do
    it { is_expected.to respond_to(:balance) }
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top-up' do
    it { is_expected.to respond_to(:top_up).with(1).argument}
    it "should top up the balance" do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by(10)
    end
    it "should not exceed balance limit" do
      max_limit = Oystercard::MAX
      subject.top_up(max_limit)
      expect { subject.top_up(1) }.to raise_error ("#{Oystercard::MAX} limit reached")
    end
  end
  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument}
    it "should reduce the balance by a specified amount" do
      expect{ subject.deduct(10) }.to change{ subject.balance }.by(-10)
    end

  end
end
