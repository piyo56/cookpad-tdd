require 'clock'

describe Clock do
  let(:clock_10_20) { Clock.new(10, 20, 00) }

  # simple setter/getter tests
  describe "Basic Tests" do
    context "new(10, 20, 00)" do
      specify { expect(clock_10_20.hour).to eq(10) }
      specify { expect(clock_10_20.min).to eq(20) }
      specify { expect(clock_10_20.sec).to eq(00) }
    end

    context "new(10, 30, 0)" do
      let(:clock) { Clock.new(12, 30, 00) }
      specify { expect(clock.hour).to eq(12) }
    end
  end
  
  # exception tests
  describe "Argument Tests" do
    context "Big value" do 
      specify { expect{ Clock.new(12, 30, 60) }.to raise_error(ArgumentError) }
    end
    
    context "negative value" do 
      specify { expect{ Clock.new(12, 30, -20) }.to raise_error(ArgumentError) }
    end
  end

  # time tests
  describe "#to_time" do
    context "(Time.today)" do
      let(:time) { clock_10_20.to_time(Date.new(2016, 12, 19)) }
      specify do
        expect(time.iso8601).to eq "2016-12-19T10:20:00+09:00"
      end
    end

    context "(2016-08-01)" do
      let(:time) { clock_10_20.to_time(Date.new(2016, 8, 1)) }
      specify do
        expect(time.iso8601).to eq "2016-08-01T10:20:00+09:00"
      end
    end

    let(:time_12_19) { Time.local(2016, 12, 19, 10, 20, 0) }
    let(:time_12_31) { Time.local(2016, 12, 31, 10, 20, 0) }
    let(:time_1_1) { Time.local(2017, 1, 1, 10, 20, 0) }

    context "next time1" do
      specify do 
        expect(clock_10_20.next_time(time_12_19).iso8601).to \
          eq "2016-12-20T10:20:00+09:00"
      end
    end

    context "next time2" do
      specify do 
        expect(clock_10_20.next_time(time_12_31).iso8601).to \
          eq "2017-01-01T10:20:00+09:00"
      end
    end

    context "previous time1" do
      specify do 
        expect(clock_10_20.previous_time(time_12_19).iso8601).to \
          eq "2016-12-18T10:20:00+09:00"
      end
    end

    context "previous time2" do
      specify do 
        expect(clock_10_20.previous_time(time_1_1).iso8601).to \
          eq "2016-12-31T10:20:00+09:00"
      end
    end

    context "next_wday1" do
      let(:time) { Time.local( 2016, 12, 19, 12, 30, 0 ) }
      specify do 
        expect(clock_10_20.next_wday(time, "Wed", 10, 20).iso8601).to \
          eq "2016-12-21T10:20:00+09:00"
      end
    end

    context "next_wday2" do
      let(:time) { Time.local( 2016, 12, 22, 12, 30, 0 ) }
      specify do 
        expect(clock_10_20.next_wday(time, "Thu", 14, 20).iso8601).to \
          eq "2016-12-22T14:20:00+09:00"
      end
    end

    context "next_wday3" do
      let(:time) { Time.local( 2016, 12, 22, 12, 30, 0 ) }
      specify do 
        expect(clock_10_20.next_wday(time, "Thu", 10, 20).iso8601).to \
          eq "2016-12-29T10:20:00+09:00"
      end
    end
  end
end
