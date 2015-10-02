describe BrailleArray, "new" do
  it "should return an empty BrailleArray"
end

describe BrailleArray, "load" do
  it "should load a valid batch of braille content"
  it "shouldn't load invalid content"
end

describe BrailleArray, "refresh" do
  it "should drop all content"
end

# depends on BrailleArrayCursor
describe BrailleArray, "line" do
  it "should return the current line"
end
