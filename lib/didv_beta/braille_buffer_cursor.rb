module DIDVBeta
  class BrailleBufferCursor

    attr_reader :position

    def initialize(lines,columns)
      @lines = lines
      @columns = columns
      @position = [line: 0,column: 0]
    end
  end
end
