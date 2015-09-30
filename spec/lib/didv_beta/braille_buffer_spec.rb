describe "BrailleBuffer", "new" do
  before(:all) { @braille_buffer =  BrailleBuffer.new(10,10) }

  it "should have the correct size" do
    expect(@braille_buffer.size).to eq [lines: 10, columns: 10]
  end

  it "should be filled with braille spaces" do
    expect(@braille_buffer.content.join.count('0')).to eq 600
  end

  it "should have position cursor at the first cell" do
    expect(@braille_buffer.cursor.position).to eq [line: 0, column: '0']
  end

end
