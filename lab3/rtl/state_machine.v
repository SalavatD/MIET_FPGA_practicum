`timescale 1ns / 1ps

module state_machine (

  // Keypress inputs
  input        set_was_pressed_i,
  
  // Current state input
  input  [2:0] state_i,
  
  // Next state output
  output [2:0] next_state_o
);

  // State machine parameters
  localparam IDLE                = 0;
  localparam CHANGE_0_DIGIT_MODE = 1;
  localparam CHANGE_1_DIGIT_MODE = 2;
  localparam CHANGE_2_DIGIT_MODE = 3;
  localparam CHANGE_3_DIGIT_MODE = 4;
  
  // Next state state machine
  reg [2:0] next_state_data;
  
  always @( * ) begin
    case ( state_i )
      IDLE:                if ( set_was_pressed_i ) next_state_data <= CHANGE_0_DIGIT_MODE;
                           else                     next_state_data <= IDLE;
                           
      CHANGE_0_DIGIT_MODE: if ( set_was_pressed_i ) next_state_data <= CHANGE_1_DIGIT_MODE;
                           else                     next_state_data <= CHANGE_0_DIGIT_MODE;
                           
      CHANGE_1_DIGIT_MODE: if ( set_was_pressed_i ) next_state_data <= CHANGE_2_DIGIT_MODE;
                           else                     next_state_data <= CHANGE_1_DIGIT_MODE;
                           
      CHANGE_2_DIGIT_MODE: if ( set_was_pressed_i ) next_state_data <= CHANGE_3_DIGIT_MODE;
                           else                     next_state_data <= CHANGE_2_DIGIT_MODE;
                           
      CHANGE_3_DIGIT_MODE: if ( set_was_pressed_i ) next_state_data <= IDLE;
                           else                     next_state_data <= CHANGE_3_DIGIT_MODE;
                           
      default:                                      next_state_data <= IDLE;
    endcase
  end
  
  assign next_state_o = next_state_data;
endmodule
