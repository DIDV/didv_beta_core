module DIDVBeta
  class BrailleBufferCursor

    attr_accessor :position
    attr_reader :end_of_text

    def initialize(lines,columns)
      @lines, @columns = lines, columns
      @position = [0,0]
      @end_of_text = [0,0]
    end

    def increment_end_of_text(times = 1)
      serialized_coordinate = serialize_coordinate(@end_of_text)
      @end_of_text = deserialize_coordinate(serialized_coordinate + times)
      @end_of_text = [@lines - 1, @columns - 1] if @end_of_text[0] > @lines
    end

    def decrement_end_of_text(times = 1)
      serialized_coordinate = serialize_coordinate(@end_of_text)
      @end_of_text = deserialize_coordinate(serialized_coordinate - times)
      @end_of_text = [0,0] if @end_of_text[0] < 0
    end

    def position=(new_position)
      unless new_position[0] < 0 or
             new_position[1] < 0 or
             serialize_coordinate(new_position) > serialize_coordinate(@end_of_text)
        @position = new_position
      end
    end

    def jump(new_position)
      case new_position
      when :eot then @position = @end_of_text
      when :sot then @position = [0,0]
      when :sol then @position[1] = 0
      when :eol then go_to_eol
      when :next_line then go_to_next_line
      when :last_line then go_to_last_line
      else self.position = new_position
      end
    end

    def step(direction)
      serialized_position = serialize_coordinate(@position)
      case direction
      when :forward then serialized_position += 1
      when :back then serialized_position -= 1
      end
      self.position = deserialize_coordinate(serialized_position)
    end

    def end_of_text?
      @position == @end_of_text
    end

    private

    def go_to_eol
      if @position[0] == @end_of_text[0]
        @position = @end_of_line
      else
        @position[1] = @columns - 1
      end
    end

    def go_to_next_line
      unless @position[0] == @end_of_text[0]
        @position[0] += 1
      end
    end

    def go_to_last_line
      unless @position[0] == 0
        @position[0] -= 1
      end
    end

    def serialize_coordinate(coordinate)
      line, column = coordinate
      line * @columns + column
    end

    def deserialize_coordinate(serialized_coordinate)
      [ serialized_coordinate / @columns, serialized_coordinate % @columns ]
    end

  end
end
