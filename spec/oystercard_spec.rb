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
    # it "should not exceed balance limit" do
    #   expect{ subject.top_up(91) }.to raise_error "limit reached"
    # end
  end
end
