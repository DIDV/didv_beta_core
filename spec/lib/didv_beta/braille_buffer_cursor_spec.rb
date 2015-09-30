describe BrailleBufferCursor, "new" do
  it "should be at start of text" do
    @cursor = BrailleBufferCursor.new
    expect(@cursor.position).to eq [0,0]
  end
end

describe BrailleBufferCursor, "end_of_text" do
  before(:all) { @cursor = BrailleBufferCursor.new }
  before(:each) { @cursor.end_of_text = [4,4] }
  
  it "should return end_of_text" do
    expect(@cursor.end_of_text).to eq [4,4]
  end
  it "should increment end_of_text" do
    @cursor.increment_end_of_text
    expect(@cursor.end_of_text).to eq [4,5]
  end
  it "should decrement end_of_text" do
    @cursor.increment_end_of_text
    expect(@cursor.end_of_text).to eq [4,3]
  end
end

describe BrailleBufferCursor, "jump" do
  it "should jump to a position between start_of_text and end_of_text"
  it "shouldn't jump to a position after last_char_position"
  it "should jump to the end_of_text"
  it "should jump to the start_of_text"
  it "should jump to the start_of_line"
  it "should jump to the end_of_line"
  it "should jump to the same column or end_of_line in next line"
  it "should jump to the same column in last line"
end

describe BrailleBufferCursor, "step" do
  it "should step forward"
  it "should step back"
  it "should step to next line"
  it "should step back to last line"
  it "shouldn't step back when at start_of_text"
  it "shouldn't step forward when at end_of_text"
end
