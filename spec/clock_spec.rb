require 'clock'

describe Clock do
  # new test #1
  context "new(10, 20, 00)" do
    let(:clock) { Clock.new(10, 20, 00) }
    specify { expect(clock.hour).to eq(10) }
    specify { expect(clock.min).to eq(20) }
    specify { expect(clock.sec).to eq(00) }
  end

  # new test #2
  context "new(10, 30, 0)" do
    let(:clock) { Clock.new(12, 30, 00) }
    specify { expect(clock.hour).to eq(12) }
  end
  
  # exception test #1
  context "new(12, 30, 60)" do
    specify { expect{ Clock.new(12, 30, 60) }.to raise_error(ArgumentError) }
  end

  # exception test #2
  context "new(12, 30, -20)" do
    specify { expect{ Clock.new(12, 30, -20) }.to raise_error(ArgumentError) }
  end
end
