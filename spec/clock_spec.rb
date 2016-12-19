require 'clock'

describe Clock do
  describe "Basic Tests" do
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
  end
  
  # exception test
  describe "Argument Tests" do
    context "Big value" do 
      specify { expect{ Clock.new(12, 30, 60) }.to raise_error(ArgumentError) }
    end
    
    context "negative value" do 
      specify { expect{ Clock.new(12, 30, -20) }.to raise_error(ArgumentError) }
    end
  end

  # time test
  describe "#to_time" do
    let(:clock) { Clock.new(10, 20, 0) }

    context "(Time.today)" do
      let(:time) { clock.to_time(Date.new(2016, 12, 19)) }
      specify do
        expect(time.iso8601).to eq "2016-12-19T10:20:00+09:00"
      end
    end

    context "(2016-08-01)" do
      let(:time) { clock.to_time(Date.new(2016, 8, 1)) }
      specify do
        expect(time.iso8601).to eq "2016-08-01T10:20:00+09:00"
      end
    end
  end
end
