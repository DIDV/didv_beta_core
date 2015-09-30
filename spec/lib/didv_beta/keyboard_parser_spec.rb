describe KeyboardParser, "input" do

  before(:all) { @keyboard_parser = KeyboardParser.new }
  before(:each) { @keyboard_parser.clear_buffer }

  it "should get a valid control input" do
    @keyboard_parser.input = 0b1000000000000 #a valid control input
    expect(@keyboard_parser.control_input).to eq(0b100000)
    expect(@keyboard_parser.char_input).to be_nil

  end

  it "should get a valid space input" do
    @keyboard_parser.input = 0b0000001000000 #a valid space input
    expect(@keyboard_parser.control_input).to be_nil
    expect(@keyboard_parser.char_input).to eq(0b000000)
  end

  it "should get a valid braille char input" do
    @keyboard_parser.input = 0b0000000000001 #a valid braille char input
    expect(@keyboard_parser.control_input).to be_nil
    expect(@keyboard_parser.char_input).to eq(0b000001)
  end

  it "should ignore when more than one control button is pressed" do
    @keyboard_parser.input = 0b1100000000000 #an invalid control input
    expect(@keyboard_parser.control_input).to be_nil
    expect(@keyboard_parser.char_input).to be_nil
  end

  it "should ignore a braille char input when there is any control input" do
    @keyboard_parser.input = 0b1000000000001 #a valid control and braille input
    expect(@keyboard_parser.control_input).to eq(0b100000)
    expect(@keyboard_parser.char_input).to be_nil
  end

  it "should ignore a braille char input when there is a space input" do
    @keyboard_parser.input = 0b0000001000001 #a valid space and braille input
    expect(@keyboard_parser.control_input).to be_nil
    expect(@keyboard_parser.char_input).to eq(0b000000)
  end

end

describe KeyboardParser, "output" do

  before(:all) { @keyboard_parser = KeyboardParser.new }
  before(:each) { @keyboard_parser.clear_buffer }

  it "should respond the end control" do
    @keyboard_parser.input=(1 << 12)
    expect(@keyboard_parser.output).to eq :end
  end

  it "should respond the left control" do
    @keyboard_parser.input=(1 << 11)
    expect(@keyboard_parser.output).to eq :left
  end

  it "should respond the right control" do
    @keyboard_parser.input=(1 << 10)
    expect(@keyboard_parser.output).to eq :right
  end

  it "should respond the enter control" do
    @keyboard_parser.input=(1 << 9)
    expect(@keyboard_parser.output).to eq :enter
  end

  it "should respond the backspace control" do
    @keyboard_parser.input=(1 << 8)
    expect(@keyboard_parser.output).to eq :backspace
  end

  it "should respond the esc control" do
    @keyboard_parser.input=(1 << 7)
    expect(@keyboard_parser.output).to eq :esc
  end

  it "should respond the space braille char" do
    @keyboard_parser.input=(1 << 6)
    expect(@keyboard_parser.output).to eq "000000"
  end

  it "should respond a valid braille char" do
    @keyboard_parser.input=(0b011001)
    expect(@keyboard_parser.output).to eq "011001"
  end


  it "should be nil by default" do
    expect(@keyboard_parser.output).to be_nil
  end

  it "should respond nil to a invalid input" do
    @keyboard_parser.input = 0b1100000000000 #an invalid control input
    expect(@keyboard_parser.output).to be_nil
  end

end
