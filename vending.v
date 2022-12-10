// Example Prices: A1 = 100, B2 = 250, C1 = 150, D3 = 200
// Example Test Cases. 
// Test Case 1: Basic Input with Exact Change
// Inputs: A -> 1, Change = 100, 		Expected Outputs: O_SEL = 0000, O_SUCCESS = 1
// Test Case 2: Not enough Change
// Inputs: B -> 2, Change = 200, 	Expected Outputs: O_PRICE = 250. 
// Test Case 3: User presses Letters several time in a row. Use Last letter pressed. 
// Inputs: A -> B -> D -> 4, Change = 400,   Expected Outputs: O_SEL = 1111, O_CHANGE = 200, O_SUCCESS = 1
		

module vending_machine (I_RESET, I_CHANGE, I_SWA, I_SWB, I_SWC, I_SWD, I_SW1, I_SW2, I_SW3, I_SW4, O_CHANGE, O_PRICE, O_SEL, O_SUCCESS);
    input I_RESET;
	
	// For button inputs assume that two buttons can't be pressed at once. 
	// So A=1, B=0, C=0, D=0 is valid but A=1, B=1, C=0, D=0 is not valid. 
	input I_SWA;
	input I_SWB;
	input I_SWC;
	input I_SWD;
	input I_SW1;
	input I_SW2;
	input I_SW3;
	input I_SW4;
	
	// I_CHANGE is an incrementing value that increases and resets when O_SUCCESS is set to 1.
	// I_CHANGE can increment by any coin value. So it can increment by 1, 5, 10, 25, 100, 500. 
	// 100 is equivalent to 1 dollar while 1 is equivalent to 1 cent. 
    input [15:0] I_CHANGE; 
	
	// O_CHANGE is the change dispensed after a selection has dispensed. 
	output reg [15:0] O_CHANGE;
	
	// O_PRICE is the price of a given selection. So for example, 1A selection may have a price of $2 (200)
	output reg [15:0] O_PRICE;
	
	// O_SEL is the output selection. When input is 1A then O_SEL = 0000 and when input is 4D then O_SEL=1111
    output reg [3:0] O_SEL;
	
	// O_SUCCESS outputs a 1 when a successful transaction has occured. This gives some feedback for an
	// external block that could be added. 
    output reg O_SUCCESS;

    parameter 	S_IDLE  				= 3'b000,
				S_WAIT_FOR_VALID_SEL 	= 3'b001,
				S_CHECK_CHANGE			= 3'b010,
				S_DISPENSE				= 3'b011,
				S_GIVE_CHANGE			= 3'b100;


    reg [2:0] state; // use to update states
	reg [3:0] selection; // 0-15 match up with O_SEL
	
	// TODO add a lookup for prices of 16 items. Update required once selection is made. 
	reg [15:0] required; 
    
    always @(I_RESET, I_SEL, I_CHANGE, I_SWA, I_SWB, I_SWC, I_SWD, I_SW1, I_SW2, I_SW3, I_SW4)
    begin
		if (I_RESET == 1) begin
			state <= S_GIVE_CHANGE;
		end
		else begin
			case(state)
				S_IDLE: begin
					// If one of letter buttons is pressed then go to S_WAIT_FOR_VALID_SEL
				end
				S_WAIT_FOR_VALID_SEL: begin
					// Keep track of latest button pressed to update selection register. 
					// If a valid selection has been entered transition to S_CHECK_CHANGE
				end
				S_CHECK_CHANGE: begin
					// Update required signal with price for given selection. 
					// If there is enough change then go to S_DISPENSE. 
					// If there isn't enough change then got to S_WAIT_FOR_INPUT. 
				end
				S_DISPENSE: begin
					// Update O_SEL with selection captured from button inputs. 
					// If no change is required go back to S_IDLE
					// If change is required go back to S_GIVE_CHANGE
				end
				S_GIVE_CHANGE: begin
					// Update O_CHANGE with remainder from I_CHANGE - required. 
				end
			endcase
		end
	end
endmodule
