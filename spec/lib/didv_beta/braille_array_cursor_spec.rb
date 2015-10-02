describe BrailleArrayCursor, 'new' do
  it "should be at start of text"
end

describe BrailleArrayCursor, 'jump' do
  it "should jump to a given position"
  it "should jump to start of line"
  it "should jump to end of line"
  it "should jump to start of text"
  it "should jump to end of text"
  it "should jump to the same column in the next line"
  it "should jump to the same column in the last line"
  it "shouldn't jump to a negative position"
  it "shouldn't jump to a position beyond end of text"
end

describe BrailleArrayCursor, 'step' do
  it "should step forward"
  it "should step back"
  it "shouldn't step back when at start of text"
  it "shouldn't step forward when at end of text"
end
