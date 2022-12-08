module Test_Vending_Exact_Change();
reg clk, reset;
reg [15:0] money_input;
reg swa, swb, swc, swd, sw1, sw2, sw3, sw4;
wire [15:0] change, price;
wire [3:0] selection;
wire success;

test_vending VEND(reset, money_input, swa, swb, swc, swd, sw1, sw2, sw3, sw4, change, price, selection, success);

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

module Test_Vending_Invalid_Selection();
reg clk, reset;
reg [15:0] money_input;
reg swa, swb, swc, swd, sw1, sw2, sw3, sw4;
wire [15:0] change, price;
wire [3:0] selection;
wire success;

test_vending VEND(reset, money_input, swa, swb, swc, swd, sw1, sw2, sw3, sw4, change, price, selection, success);

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

module Test_Vending_Timeout_Case();
reg clk, reset;
reg [15:0] money_input;
reg swa, swb, swc, swd, sw1, sw2, sw3, sw4;
wire [15:0] change, price;
wire [3:0] selection;
wire success;

test_vending VEND(reset, money_input, swa, swb, swc, swd, sw1, sw2, sw3, sw4, change, price, selection, success);

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

begin
	#5 coins = 100;
end

endmodule
