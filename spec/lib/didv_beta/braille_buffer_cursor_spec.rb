describe BrailleBufferCursor, "new" do
  it "should be at start of text" do
    @cursor = BrailleBufferCursor.new(10,10)
    expect(@cursor.position).to eq [0,0]
  end
end

describe BrailleBufferCursor, "end_of_text" do
  before(:all) do
     @cursor = BrailleBufferCursor.new(10,10)
     @cursor.increment_end_of_text(44)
   end

  it "should return end_of_text" do
    expect(@cursor.end_of_text).to eq [4,4]
  end

  it "should increment end_of_text" do
    @cursor.increment_end_of_text
    expect(@cursor.end_of_text).to eq [4,5]
  end

  it "should decrement end_of_text" do
    @cursor.decrement_end_of_text
    expect(@cursor.end_of_text).to eq [4,4]
  end

  it "shouldn't increment end_of_text when buffer is over" do
    @cursor.increment_end_of_text(200)
    expect(@cursor.end_of_text).to eq [9,9]
  end

  it "shouldn't decrement end_of_text when buffer is at beginning" do
    @cursor.decrement_end_of_text(200)
    expect(@cursor.end_of_text).to eq [0,0]
  end

end

describe BrailleBufferCursor, "jump" do

  before(:all) do
    @cursor = BrailleBufferCursor.new(10,10)
    @cursor.increment_end_of_text(49)
  end

  before(:each) { @cursor.jump [2,2] }

  it "should jump to a position between start_of_text and end_of_text" do
    new_position = rand(49)
    line, column = new_position / 10, new_position % 10
    @cursor.jump [line, column]
    expect(@cursor.position).to eq [line, column]
  end

  it "shouldn't jump to a position after end_of_text" do
    @cursor.jump [5,0]
    expect(@cursor.position).to eq [2,2]
  end

  it "shouldn't jump to a position before end_of_text" do
    @cursor.jump [-10, -4]
    expect(@cursor.position).to eq [2,2]
  end

  it "should jump to the end_of_text" do
    @cursor.jump :eot
    expect(@cursor.position).to eq @cursor.end_of_text
    expect(@cursor.end_of_text?).to be true
  end

  it "should jump to the start_of_text" do
    @cursor.jump :sot
    expect(@cursor.position).to eq [0,0]
  end

  it "should jump to the start_of_line" do
    @cursor.jump :sol
    expect(@cursor.position).to eq [2,0]
  end

  it "should jump to the end_of_line" do
    @cursor.jump :eol
    expect(@cursor.position).to eq [2,9]
  end

  it "should jump to the same column or end_of_line in next line" do
    @cursor.jump :next_line
    expect(@cursor.position).to eq [3,2]
  end

  it "should jump to the same column in last line" do
    @cursor.jump(:last_line)
    expect(@cursor.position).to eq [1,2]
  end

  it "shouldn't jump to the next line when cursor at end_of_text line" do
    @cursor.jump(:eot)
    @cursor.jump(:next_line)
    expect(@cursor.position).to eq @cursor.end_of_text
  end

  it "shouldn't jump to the last line when cursor at first line" do
    @cursor.jump(:sot)
    @cursor.jump(:last_line)
    expect(@cursor.position).to eq [0,0]
  end

end

describe BrailleBufferCursor, "step" do
  before(:all) do
    @cursor = BrailleBufferCursor.new(10,10)
    @cursor.increment_end_of_text(44)
  end
  before(:each) { @cursor.jump [2,2] }

  it "should step forward" do
    @cursor.step :forward
    expect(@cursor.position).to eq [2,3]
  end

  it "should step back" do
    @cursor.step :back
    expect(@cursor.position).to eq [2,1]
  end

  it "should step to next line" do
    @cursor.jump :eol
    @cursor.step :forward
    expect(@cursor.position).to eq [3,0]
  end

  it "should step back to last line" do
    @cursor.jump :sol
    @cursor.step :back
    expect(@cursor.position).to eq [1,9]
  end

  it "shouldn't step back when at start_of_text" do
    @cursor.jump :sot
    @cursor.step :back
    expect(@cursor.position).to eq [0,0]
  end

  it "shouldn't step forward when at end_of_text" do
    @cursor.jump :eot
    @cursor.step :forward
    expect(@cursor.position).to eq @cursor.end_of_text
  end
end
