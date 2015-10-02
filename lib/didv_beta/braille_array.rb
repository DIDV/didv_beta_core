module DIDVBeta
  class BrailleArray

    attr_accessor :columns

    def initialize(columns = 1)
      @content = []
      @columns = columns
      @cursor = BrailleArrayCursor.new(@columns)
    end

    def load(content)
      content = parse_braille(content)
      if content == false
        return false
      else
        @content.concat content.flatten
        return true
      end
    end

    def join
      @content.join
    end

    def empty?
      @content.empty?
    end

    private

    def parse_braille(content)
      parsed_braille = []
      content.each_line do |line|
        line = line.chars
        braille_chars = []
        braille_chars << line.shift(6).join until line.empty?
        if braille_chars.collect {|char| valid_braille? char }.include? false
          parsed_braille = false
          break
        else
          parsed_braille << braille_chars
        end
      end
      parsed_braille
    end

    def valid_braille?(char)
      char =~ /\A[01]{6}\z/ or char == "\n"
    end

  end
end
