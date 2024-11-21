// Code your design here
module FSM(
  input wire clk,
  input wire rst_n,
  input wire read_en,
  input wire finish,
  
  output reg load,
  output reg shift
);
  
  typedef enum reg [1:0]{
   IDLE   = 2'b00,
   LOAD   = 2'b01,
   SHIFT  = 2'b10
} state_t;

  state_t current_state, next_state;
  
  typedef struct packed {
    reg load_signal;
    reg shift_signal;
  }signal_t;
  
  signal_t current_signal, next_signal;
  
  always@(posedge clk or negedge rst_n)	begin
    if(!rst_n)	begin
      current_signal<='{default:0};
      current_state<=IDLE;
    end
    else	begin
      current_state<=next_state;
      current_signal<=next_signal;
    end
  end
  
  always@(*)	begin
    next_state=IDLE;
    next_signal='{default:0};
    case(current_state)	
      IDLE:	begin
        if(read_en)	begin
        	next_state=LOAD;
          	next_signal.load_signal=1'b1;
          	next_signal.shift_signal=1'b0;
        end
        else	begin
          next_state=IDLE;
    	  next_signal='{default:0};
        end
      end
      
      LOAD:	begin
        	next_state=SHIFT;
          	next_signal.shift_signal=1'b1;
        	next_signal.load_signal=1'b0;
      end
      
      SHIFT:	begin
        if(finish)	begin
          next_state=IDLE;
    	  next_signal='{default:0};
        end
        else	begin
          next_state=current_state;
          next_signal=current_signal;
        end
      end
    endcase
  end
  assign load=current_signal.load_signal;
  assign shift=current_signal.shift_signal;
endmodule: FSM