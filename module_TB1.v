module tb();

reg clk, write, read;

typedef struct{
	reg [7:0] data_in_tb; // data to write 
	reg [15:0] address_tb; //address to read/write
	wire [8:0] data_out_tb; //expected data read 
	reg [8:0] data_read; // Actual Data to read 
} transactions;


my_mem dl (.clk(clk),
				.write(write),
				.read(read),
				.data_in(data_in_tb),
				.address(address_tb),
				.data_out(data_out_tb)
				);

transactions transaction_array [6];

logic [8:0] expected_array [int], index =1;

always #5 clk = ~clk;

int i,Error_count;

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
	write =1;
	read = 0;
	for (i=0; i<6; i=i+1) begin
		address = transaction_array[i].address_tb;
		data_in = transaction_array[i].data_in_tb;
		transaction_array[i]. data_out_tb = transaction_array[i].data_in_tb; 
	end
	#5;


//Shuffle
	for (i=5; i<1; i=i-1) begin
		int j = $urandom (i);
		transactions temp = transaction_array [i];
		transaction_array[i] = transaction_array [j];
		transaction_array[j] = temp;
	end
	#5;


//Read 
	read =1;
	write =0;
	for (i=0; i<6; i=i+1) begin
		address = transaction_array [i].address_tb;
		transaction_array[i].data_read = data_out;
		Checkoutput (transaction_array[i].data_read, transaction_array[i].data_out_tb);
	end
	#5;
		
	repeat (5) @ (posedge clk);
	$finish;
	end


task Checkoutput (input logic [8:0] data_out_tb, expected_array);
	begin
		if (transaction_array[i].data_read == transaction_array[i].data_out_tb) begin
			$display ("success"); 
			else begin
				$display ("Error");
				Error_count = Error_count +1;
			end
		end
	end

endtask

endmodule




