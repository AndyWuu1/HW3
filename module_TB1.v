module tb();

reg clk, write, read;

my_mem dl (.clk(clk),
				.write(write),
				.read(read),
				.data_in(data_in_tb),
				.address(address_tb),
				.data_out(data_out_tb)
				);

typedef struct{
	reg [7:0] data_in_tb; // data to write 
	reg [15:0] address_tb; //address to read/write
	wire [8:0] data_out_tb; //expected data read 
	reg [8:0] data_read; // Actual Data to read 
} transactions;

transactions transaction_array [6];

always #5 clk = ~clk;

int i;

initial begin

	clk = 0;
	$vcdpluson;
	$dumpfile("dump.vcd");
	$dumpvars;

//Generate random addresses and data 
	for (i=0; i<6; i= i+1) begin
		transaction_array[i].address_tb = $urandom();
		transaction_array[i].data_in_tb = $urandom();
	end
	$display (address_tb);
	$display (data_in_tb);
	#5;


//Write 




