describe BrailleArrayCursor, 'new' do
  it "should be at start of text" do
    expect(BrailleArrayCursor.new.position).to eq 0
  end
  it "should be at informed end of text position" do
    @cursor = BrailleArrayCursor.new(10)
    expect(@cursor.position).to eq 10
  end
end

describe BrailleArrayCursor, 'jump' do
  before(:all) { @cursor = BrailleArrayCursor.new }
  before(:each) do
    @cursor.end_of_text = 99
    @cursor.columns = 10
    @cursor.jump(45)
  end

  it "should jump to a valid given position" do
    new_position = rand(99)
    @cursor.jump(new_position)
    expect(@cursor.position).to eq new_position
  end

  it "should jump to start of line" do
    new_position = rand(99)
    @cursor.jump(new_position)
    @cursor.jump(:start_of_line)
    expect(@cursor.column).to eq 0
    expect(@cursor.start_of_line?).to be true
  end

  it "should jump to end of line when line is full"  do
    @cursor.jump(:end_of_line)
    expect(@cursor.column).to eq 9
    expect(@cursor.end_of_line?).to be true
  end

  it "should jump to end of line when line is not full" do
    @cursor.end_of_text = 48
    @cursor.jump(:end_of_line)
    expect(@cursor.column).to eq 8
    expect(@cursor.end_of_line?).to be true
  end

  it "should jump to start of text" do
    @cursor.jump(:start_of_text)
    expect(@cursor.position).to eq 0
    expect(@cursor.start_of_text?).to be true
  end

  it "should jump to end of text" do
    @cursor.jump(:end_of_text)
    expect(@cursor.position).to eq 99
    expect(@cursor.end_of_text?).to be true
  end

  it "should jump to the same column at next line when next line is full" do
    @cursor.jump(:next_line)
    expect(@cursor.position).to eq 55
  end

  it "should jump to the closer column at next line when next line isn't full" do
    @cursor.end_of_text = 53
    @cursor.jump(:next_line)
    expect(@cursor.position).to eq 53
  end

  it "shouldn't jump to next line when at end_of_text line" do
    @cursor.jump(91)
    @cursor.jump(:next_line)
    expect(@cursor.position).to eq 91
  end

  it "should jump to the same column in the last line" do
    @cursor.jump(:last_line)
    expect(@cursor.position).to eq 35
  end

  it "shouldn't jump to last line when at start_of_text line" do
    @cursor.jump(5)
    @cursor.jump(:last_line)
    expect(@cursor.position).to eq 5
  end

  it "shouldn't jump to a negative position" do
    @cursor.jump(-10)
    expect(@cursor.position).to eq 45
  end

  it "shouldn't jump to a position beyond end of text" do
    @cursor.jump(200)
    expect(@cursor.position).to eq 45
  end

end

describe BrailleArrayCursor, 'step' do
  before(:all) { @cursor = BrailleArrayCursor.new }
  before(:each) do
    @cursor.end_of_text = 99
    @cursor.columns = 10
    @cursor.jump(45)
  end

  it "should step forward" do
    @cursor.step(:forward)
    expect(@cursor.position).to eq 46
  end

  it "should step back" do
    @cursor.step(:back)
    expect(@cursor.position).to eq 44
  end

  it "shouldn't step back when at start of text" do
    @cursor.jump(:start_of_text)
    @cursor.step(:back)
    expect(@cursor.position).to eq 0
    expect(@cursor.start_of_text?).to be true
  end

  it "shouldn't step forward when at end of text" do
    @cursor.jump(:end_of_text)
    @cursor.step(:forward)
    expect(@cursor.position).to eq 99
    expect(@cursor.end_of_text?).to be true
  end

end
