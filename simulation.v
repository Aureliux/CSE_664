//Test Case 1: Exact Change Case
//Test Case 2: Dispense Change Case (Value put in is higher than value needed)
//Test Case 3: Invalid Selection
//Test Case 4: Not enough money inserted
//Test Case 5: Timeout Case (Dispense money after a certain amount of time)
//Test Case 6: Reset Case (Plug is pulled. Vending machine needs to dispense all money)

module Test_Vending_Exact_Change();
reg clk, reset;
reg [15:0] money_input;
reg swa, swb, swc, swd, sw1, sw2, sw3, sw4;
wire [15:0] change, price;
wire [3:0] selection;
wire success;

vending_machine VEND(reset, money_input, swa, swb, swc, swd, sw1, sw2, sw3, sw4, change, price, selection, success);

initial
begin
	clk = 0;
	reset = 0;
	swa = 0;
	swb = 0;
	swc = 0;
	swd = 0;
	sw1 = 0;
	sw2 = 0;
	sw3 = 0;
	sw4 = 0;
	money_input = 0;
	

	forever #5 clk=~clk;
end

always
begin
	#5 money_input = 25;
	#10 money_input = money_input + 25;
	#10 money_input = money_input + 25;
	#10 money_input = money_input + 25;
	#15 swa = 1;
	#10 swa = 0;
	#50 money_input = 100;
	#50 money_input = 100;
	#15 swd = 1;
	#10 swd = 0;
end

endmodule

// For this case the user will insert $2 then press A3.
// Since A3 is $1.50 then the user should be given .50c in change
module Test_Dispense_Change();
reg clk, reset;
reg [15:0] money_input;
reg swa, swb, swc, swd, sw1, sw2, sw3, sw4;
wire [15:0] change, price;
wire [3:0] selection;
wire success;

vending_machine VEND(reset, money_input, swa, swb, swc, swd, sw1, sw2, sw3, sw4, change, price, selection, success);

initial
begin
	clk = 0;
	reset = 0;
	swa = 0;
	swb = 0;
	swc = 0;
	swd = 0;
	sw1 = 0;
	sw2 = 0;
	sw3 = 0;
	sw4 = 0;
	money_input = 0;
	

	forever #5 clk=~clk;
end

always
begin
	#5 money_input = 100;
	#10 money_input = money_input + 100;
	#15 swa = 1;
	#10 swa = 0;
	#15 sw3 = 1;
	#10 sw3 = 0;
	
	// Check that change is equal to 50c
	// Check that selection is equal to 2 which maps to A3
end

endmodule

module Test_Vending_Invalid_Selection();
reg clk, reset;
reg [15:0] money_input;
reg swa, swb, swc, swd, sw1, sw2, sw3, sw4;
wire [15:0] change, price;
wire [3:0] selection;
wire success;

vending_machine VEND(reset, money_input, swa, swb, swc, swd, sw1, sw2, sw3, sw4, change, price, selection, success);

initial
begin
	clk = 0;
	reset = 0;
	swa = 0;
	swb = 0;
	swc = 0;
	swd = 0;
	sw1 = 0;
	sw2 = 0;
	sw3 = 0;
	sw4 = 0;
	money_input = 0;
	

	forever #5 clk=~clk;
end

always
begin
	#5 money_input = 25;
	#10 money_input = money_input + 50;
	#10 money_input = money_input + 50;
	#10 money_input = money_input + 75;
	#15 swa = 1;
	swb = 1;
	#10 swa = 0;
	swb = 0;
	#50 money_input = 100;
	#50 money_input = 100;
	#15 swd = 1;
	#10 swd = 0;
end

endmodule

// For this case the user will insert $2 then press B1.
// Since B3 is $2.50 then the price will be outputted to the user
module Test_Not_Enough_Change();
reg clk, reset;
reg [15:0] money_input;
reg swa, swb, swc, swd, sw1, sw2, sw3, sw4;
wire [15:0] change, price;
wire [3:0] selection;
wire success;

vending_machine VEND(reset, money_input, swa, swb, swc, swd, sw1, sw2, sw3, sw4, change, price, selection, success);

initial
begin
	clk = 0;
	reset = 0;
	swa = 0;
	swb = 0;
	swc = 0;
	swd = 0;
	sw1 = 0;
	sw2 = 0;
	sw3 = 0;
	sw4 = 0;
	money_input = 0;
	

	forever #5 clk=~clk;
end

always
begin
	#5 money_input = 100;
	#10 money_input = money_input + 100;
	#15 swb = 1;
	#10 swb = 0;
	#15 sw1 = 1;
	#10 sw1 = 0;
	
	// Check that price is equal to 250
end

endmodule

module Test_Vending_Timeout_Case();
reg clk, reset;
reg [15:0] money_input;
reg swa, swb, swc, swd, sw1, sw2, sw3, sw4;
wire [15:0] change, price;
wire [3:0] selection;
wire success;

vending_machine VEND(reset, money_input, swa, swb, swc, swd, sw1, sw2, sw3, sw4, change, price, selection, success);

initial
begin
	clk = 0;
	reset = 0;
	swa = 0;
	swb = 0;
	swc = 0;
	swd = 0;
	sw1 = 0;
	sw2 = 0;
	sw3 = 0;
	sw4 = 0;
	money_input = 0;
	

	forever #5 clk=~clk;
end

always
begin
	#5 money_input = 100;
end

endmodule

// In this test case, the user will insert change the plug will be pulled (I_RESET = 1)
module Test_Reset_Case();
reg clk, reset;
reg [15:0] money_input;
reg swa, swb, swc, swd, sw1, sw2, sw3, sw4;
wire [15:0] change, price;
wire [3:0] selection;
wire success;

vending_machine VEND(reset, money_input, swa, swb, swc, swd, sw1, sw2, sw3, sw4, change, price, selection, success);

initial
begin
	clk = 0;
	reset = 0;
	swa = 0;
	swb = 0;
	swc = 0;
	swd = 0;
	sw1 = 0;
	sw2 = 0;
	sw3 = 0;
	sw4 = 0;
	money_input = 0;
	

	forever #5 clk=~clk;
end

always
begin
	#5 money_input = 100;
	#20 reset = 1;
	
	// Verify that change is 100. 
end

endmodule

