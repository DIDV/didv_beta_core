module DIDVBeta
  class BrailleArrayCursor

    attr_reader :position
    attr_accessor :end_of_text, :columns

    def initialize(end_of_text = 0)
      @end_of_text = end_of_text
      @position = @end_of_text
    end

    def column
      @position % @columns
    end

    def line
      @position / @columns
    end

    def jump(new_position)
      case new_position
      when :start_of_line then go_to_start_of_line
      when :end_of_line then go_to_end_of_line
      when :start_of_text then go_to_start_of_text
      when :end_of_text then go_to_end_of_text
      when :next_line then go_to_next_line
      when :last_line then go_to_last_line
      else @position = new_position if new_position.between? 0, @end_of_text
      end
    end

    def step(direction)
      case direction
      when :forward then step_forward
      when :back then step_back
      end
    end

    def start_of_line?
      column == 0
    end

    def end_of_line?
      column == @columns - 1 or @position == @end_of_text
    end

    def start_of_text?
      @position == 0
    end

    def end_of_text?
      @position == @end_of_text
    end

    private

    def go_to_start_of_line
      @position = line * @columns
    end

    def go_to_end_of_line
      end_of_line = (line * @columns) + @columns - 1
      end_of_text_or end_of_line
    end

    def go_to_start_of_text
      @position = 0
    end

    def go_to_end_of_text
      @position = @end_of_text
    end

    def go_to_next_line
      next_line = ( line + 1 ) * @columns + column
      end_of_text_or next_line unless line == @end_of_text / @columns
    end

    def go_to_last_line
      last_line = ( line - 1 ) * @columns + column
      jump(last_line)
    end

    def step_forward
      end_of_text_or @position + 1
    end

    def step_back
      @position -= 1 unless @position == 0
    end

    def end_of_text_or(position)
      position = @end_of_text if position > @end_of_text
      @position = position
    end

  end
end
