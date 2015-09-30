module DIDVBeta
  class BrailleBuffer

    attr_reader :cursor

    def initialize(lines,columns)
      @lines = lines
      @columns = columns
      @cursor = BrailleBufferCursor.new
      initialize_buffer
    end

    def size
      [lines: @lines, columns: @columns]
    end

    def content
      @buffer.flatten
    end

    private

    def initialize_buffer
      @buffer = []
      (0..@lines-1).each do |line|
        @buffer[line] = []
        @columns.times { @buffer[line] << '000000' }
      end
    end

  end
end
