module vending_machine (I_RESET, I_SEL, I_CHANGE, O_SEL, O_ERROR);
    input I_RESET;
    input [3:0] I_SEL;
    input [15:0] I_CHANGE;
    output reg [3:0] O_SEL;
    output reg O_ERROR;

    parameter 	S_IDLE  	= 3'b000,
				S_COUNT 	= 3'b001,
				S_CHOOSE_ITEM	= 3'b010,
				S_ERROR		= 3'b011,
				S_DISPENSE	= 3'b100,
				S_GIVE_CHANGE	= 3'b101;


    reg [2:0] state;
    
    always @(I_RESET, I_SEL, I_CHANGE)
    begin
		if (I_RESET == 1) begin
			state <= S_IDLE;
		end
		else begin
			case(state)
				S_IDLE: begin
					// Insert Idle state actions
				end
				S_COUNT: begin
					// Insert Count state actions
				end
				S_CHOOSE_ITEM: begin
					// Insert Choose Item state actions
				end
				S_ERROR: begin
					// Insert Error state actions
				end
				S_DISPENSE: begin
					// Insert Dispense state actions
				end
				S_GIVE_CHANGE: begin
					// Insert Give Change state actions
				end
			endcase
		end
	end
endmodule
