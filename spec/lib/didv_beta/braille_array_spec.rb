describe BrailleArray, "new" do
  before(:all) do
    @braille_array = BrailleArray.new
    @braille_array.columns = 10
  end

  it "should return an empty BrailleArray" do
    expect(@braille_array.class).to eq BrailleArray
  end

  it "should return the correct column size" do
    expect(@braille_array.columns).to eq 10
  end

end

describe BrailleArray, "load" do
  before(:each) do
    @braille_array = BrailleArray.new
  end

  it "should load a valid batch of braille content" do
    valid_content = "100100110110011110\n111110\n100010"
    expect(@braille_array.load(valid_content)).to be true
    expect(@braille_array.join).to eq valid_content
  end

  it "shouldn't load invalid content" do
    invalid_content = "100100110110011110\n11111\n100010"
    expect(@braille_array.load(invalid_content)).to be false
    expect(@braille_array.empty?).to be true

    invalid_content = "any invalid content, really"
    expect(@braille_array.load(invalid_content)).to be false
    expect(@braille_array.empty?).to be true
  end

end

# depends on BrailleArrayCursor
describe BrailleArray, "line" do
  it "should return the current line"
end
