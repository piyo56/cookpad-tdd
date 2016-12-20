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
  end

  describe "#next_time（曜日指定無し）" do

    context "明日の10:20となる場合" do
      let(:time){ Time.local(2016, 12, 19, 11, 20, 0) }
      specify do 
        expect(clock_10_20.next_time(time).iso8601).to \
          eq "2016-12-20T10:20:00+09:00"
      end
    end
    context "今日の10:20となる場合" do
      let(:time){ Time.local(2016, 12, 19, 9, 20, 0) }
      specify do 
        expect(clock_10_20.next_time(time).iso8601).to \
          eq "2016-12-19T10:20:00+09:00"
      end
    end
  end

  describe "#next_time（曜日指定有り）" do

    context "次の水(3)の10:20となる場合1" do
      let(:time){ Time.local(2016, 12, 21, 11, 20, 0) }
      specify do 
        expect(clock_10_20.next_time(time, 3).iso8601).to \
          eq "2016-12-28T10:20:00+09:00"
      end
    end
    
    context "次の水(3)の10:20となる場合2" do
      let(:time){ Time.local(2016, 12, 23, 11, 20, 0) }
      specify do
        expect(clock_10_20.next_time(time, 3).iso8601).to \
          eq "2016-12-28T10:20:00+09:00"
      end
    end

    context "今日の10:20となる場合" do
      let(:time){ Time.local(2016, 12, 21, 9, 20, 0) }
      specify do 
        expect(clock_10_20.next_time(time, 3).iso8601).to \
          eq "2016-12-21T10:20:00+09:00"
      end
    end
  end

  describe "#previous_time（曜日指定無し）" do

    context "昨日の10:20となる場合" do
      let(:time){ Time.local(2016, 12, 22, 9, 20, 0) }
      specify do 
        expect(clock_10_20.previous_time(time).iso8601).to \
          eq "2016-12-21T10:20:00+09:00"
      end
    end
    context "今日の10:20となる場合" do
      let(:time){ Time.local(2016, 12, 21, 11, 20, 0) }
      specify do 
        expect(clock_10_20.previous_time(time).iso8601).to \
          eq "2016-12-21T10:20:00+09:00"
      end
    end
  end

  describe "#previous_time（曜日指定有り）" do

    context "前の水(3)の10:20となる場合1" do
      let(:time){ Time.local(2016, 12, 28, 9, 20, 0) }
      specify do 
        expect(clock_10_20.previous_time(time, 3).iso8601).to \
          eq "2016-12-21T10:20:00+09:00"
      end
    end
    
    context "次の水(3)の10:20となる場合2" do
      let(:time){ Time.local(2016, 12, 23, 11, 20, 0) }
      specify do
        expect(clock_10_20.previous_time(time, 3).iso8601).to \
          eq "2016-12-21T10:20:00+09:00"
      end
    end

    context "今日の10:20となる場合" do
      let(:time){ Time.local(2016, 12, 21, 11, 20, 0) }
      specify do 
        expect(clock_10_20.previous_time(time, 3).iso8601).to \
          eq "2016-12-21T10:20:00+09:00"
      end
    end
  end
end
