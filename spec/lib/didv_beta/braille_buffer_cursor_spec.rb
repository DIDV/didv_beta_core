
describe "BrailleBufferCursor", "jump" do

  before(:all) { @cursor = BrailleBufferCursor.new(10,10) }
  before(:each) { @cursor.position = [3,5] }

  it "should go to the requested position" do
    expect(@cursor.position).to eq [3,5]
  end

  it "should stand in the current position if the requested position is invalid" do
    @cursor.position = [15,15]
    expect(@cursor.position).to eq [3,5]
  end

  it "should jump to the same column in the next line" do
    @cursor.line(:forward)
    expect(@cursor.position).to eq [4,5]
  end

  it "should jump back to the same column in the last line" do
    @cursor.line(:back)
    expect(@cursor.position).to eq [2,5]
  end

  it "should jump to the start of line" do
    @cursor.start_of_line
    expect(@cursor.position).to eq [3,0]
    expect(@cursor.start_of_line?).to be true
  end

  it "should jump to the end of line" do
    @cursor.end_of_line
    expect(@cursor.position).to eq [3,9]
    expect(@cursor.end_of_line?).to be true
  end

  it "should jump to the end of text" do
    @cursor.end_of_text
    expect(@cursor.position).to eq [9,9]
    expect(@cursor.end_of_text?).to be true
  end

  it "should jump to the start of text" do
    @cursor.start_of_text
    expect(@cursor.position).to eq [3,0]
    expect(@cursor.start_of_text?).to be true
  end

end

describe "BrailleBufferCursor", "step" do

  before(:all) { @cursor = BrailleBufferCursor.new(10,10) }

  it "should increment position" do
    @cursor.position = [2,9]
    @cursor.step(:forward)
    expect(@cursor.position).to eq [3,0]
  end

  it "should decrement position" do

    @cursor.step(:back)
    expect(@cursor.position).to eq [2,9]
  end

  it "shouldn't step forward after reaching the last position" do
    @cursor.position = [9,9]
    @cursor.step(:forward)
    expect(@cursor.position).to eq [9,9]
  end

  it "shouldn't step back after reaching the first position" do
    @cursor.position = [0,0]
    @cursor.step(:back)
    expect(@cursor.position).to eq [0,0]
  end

end
