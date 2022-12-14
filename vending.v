// Example Prices: A1 = 100, B2 = 250, C1 = 150, D3 = 200
// Example Test Cases. 
// Test Case 1: Basic Input with Exact Change
// Inputs: A -> 1, Change = 100, 		Expected Outputs: O_SEL = 0000, O_SUCCESS = 1
// Test Case 2: Not enough Change
// Inputs: B -> 2, Change = 200, 		Expected Outputs: O_PRICE = 250. 
// Test Case 3: User presses Letters several time in a row. Use Last letter pressed. 
// Inputs: A -> B -> D -> 4, Change = 400,   	Expected Outputs: O_SEL = 1111, O_CHANGE = 200, O_SUCCESS = 1
		

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
	
	// O_SEL is the output selection. When input is A1 then O_SEL = 0000 and when input is D4 then O_SEL = 1111.
    	output reg [3:0] O_SEL;
	
	// O_SUCCESS outputs a 1 when a successful transaction has occured. This gives some feedback for an
	// external block that could be added. 
    	output reg O_SUCCESS;

    	parameter 	S_IDLE  			= 3'b000,
			S_CHECK_SELECTION 		= 3'b001,
			S_CHECK_CHANGE			= 3'b010,
			// S_DISPENSE			= 3'b011,
			S_GIVE_CHANGE			= 3'b100;


    	reg [2:0] state; // Use to update states.
	reg [3:0] selection; // 0-15 match up with O_SEL.
	reg [15:0] required [15:0]; // Lookup for prices of 16 items.
	reg [1:0] letter_sel;


	initial begin
		required[0] = 100; // A1 Price is $1.00
		required[1] = 100; // A2 Price is $1.00
		required[2] = 150; // A3 Price is $1.50
		required[3] = 150; // A4 Price is $1.50
		required[4] = 250; // B1 Price is $2.50
		required[5] = 250; // B2 Price is $2.50
		required[6] = 150; // B3 Price is $1.50
		required[7] = 175; // B4 Price is $1.75
		required[8] = 150; // C1 Price is $1.50
		required[9] = 100; // C2 Price is $1.00
		required[10] = 125; // C3 Price is $1.25
		required[11] = 100; // C4 Price is $1.00
		required[12] = 150; // D1 Price is $1.50
		required[13] = 150; // D2 Price is $1.50
		required[14] = 200; // D3 Price is $2.00
		required[15] = 200; // D4 Price is $2.00
		selection = 0;
		state = S_IDLE;
	end
    
    	always @(I_RESET, I_CHANGE, I_SWA, I_SWB, I_SWC, I_SWD, I_SW1, I_SW2, I_SW3, I_SW4)
    	begin
		if (I_RESET == 1) begin
			state <= S_GIVE_CHANGE;
		end
		else begin
			case(state)
				S_IDLE: begin
					// If one letter button is pressed then go to S_CHECK_SELECTION.
					if (I_SWA == 1) begin
						letter_sel <= 0;
						state <= S_CHECK_SELECTION;
					end 
					else if(I_SWB == 1) begin
						letter_sel <= 1;
						state <= S_CHECK_SELECTION;
					end 
					else if(I_SWC == 1) begin
						letter_sel <= 2;
						state <= S_CHECK_SELECTION;
					end 
					else if(I_SWD == 1) begin
						letter_sel <= 3;
						state <= S_CHECK_SELECTION;
					end 
					
				end
				S_CHECK_SELECTION: begin
					// Keep track of latest button pressed to update selection register. 
					// If a valid selection has been entered transition to S_CHECK_CHANGE.
					if (letter_sel == 0 && I_SW1 == 1) begin
						selection <= 4'b0000;
						O_PRICE <= required[0];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 0 && I_SW2 == 1) begin
						selection <= 4'b0001;
						O_PRICE <= required[1];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 0 && I_SW3 == 1) begin
						selection <= 4'b0010;
						O_PRICE <= required[2];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 0 && I_SW4 == 1) begin
						selection <= 4'b0011;
						O_PRICE <= required[3];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 1 && I_SW1 == 1) begin
						selection <= 4'b0100;
						O_PRICE <= required[4];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 1 && I_SW2 == 1) begin
						selection <= 4'b0101;
						O_PRICE <= required[5];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 1 && I_SW3 == 1) begin
						selection <= 4'b0110;
						O_PRICE <= required[6];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 1 && I_SW4 == 1) begin
						selection <= 4'b0111;
						O_PRICE <= required[7];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 2 && I_SW1 == 1) begin
						selection <= 4'b1000;
						O_PRICE <= required[8];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 2 && I_SW2 == 1) begin
						selection <= 4'b1001;
						O_PRICE <= required[9];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 2 && I_SW3 == 1) begin
						selection <= 4'b1010;
						O_PRICE <= required[10];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 2 && I_SW4 == 1) begin
						selection <= 4'b1011;
						O_PRICE <= required[11];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 3 && I_SW1 == 1) begin
						selection <= 4'b1100;
						O_PRICE <= required[12];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 3 && I_SW2 == 1) begin
						selection <= 4'b1101;
						O_PRICE <= required[13];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 3 && I_SW3 == 1) begin
						selection <= 4'b1110;
						O_PRICE <= required[14];
						state <= S_CHECK_CHANGE;
					end
					else if (letter_sel == 3 && I_SW4 == 1) begin
						selection <= 4'b1111;
						O_PRICE <= required[15];
						state <= S_CHECK_CHANGE;
					end
				end
				
				// Update required signal with price for given selection. X 
				// If there is enough change then Dispense and go to S_GIVE_CHANGE. X
				// If there isn't enough change then got to S_CHECK_SELECTION. X
				// Update O_SEL with selection captured from button inputs. X
				// If no change is required go back to S_IDLE. X
				// If change is required go back to S_GIVE_CHANGE. X
				S_CHECK_CHANGE: begin
					if (I_CHANGE >= O_PRICE) begin
						O_SEL <= selection;					
						if (I_CHANGE == O_PRICE) begin
							state <= S_IDLE;
						end
						else begin
							state <= S_GIVE_CHANGE;
						end
					end
					else begin
						state <= S_IDLE;
					end								
				end					
				S_GIVE_CHANGE: begin
					O_CHANGE <= I_CHANGE - O_PRICE;
					O_PRICE <= 0;
					O_SEL <= 0;
					state <= S_IDLE; 
				end
			endcase
		end
	end
endmodule
