module DIDVBeta
  class KeyboardParser

    CONTROL_KEYS = [ :end, :left, :right, :enter, :backspace, :esc ]

    attr_reader :control_input, :char_input

    def input=(keyboard_input)
      unless extract_control_from(keyboard_input)
        extract_char_from(keyboard_input)
      end
    end

    def output
      if @control_input
        CONTROL_KEYS[ 6 -@control_input.to_s(2).size ]
      elsif @char_input
        char_output
      else
        nil
      end
    end

    def clear_buffer
      @control_input = nil
      @char_input = nil
    end

    private

    def extract_control_from(keyboard_input)
      control_input = ( 0b1111110000000 & keyboard_input ) >> 7
      if valid_control_input?(control_input)
        @control_input = control_input
      else
        @control_input = nil
      end
    end

    def extract_char_from(keyboard_input)
      char_input = keyboard_input & 0b0000001111111
      if char_input > 0
        if char_input & 0b1000000 > 0
          @char_input = 0
        else
          @char_input = 0b111111 & char_input
        end
      end
    end

    def valid_control_input?(control_input)
      control_input > 0 and control_input.to_s(2).count('1') == 1
    end

    def char_output
      char_output = @char_input.to_s(2)
      (6 - char_output.size).times { char_output = '0' + char_output }
      char_output
    end

  end
end
