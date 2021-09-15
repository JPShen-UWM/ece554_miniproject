
module tpumac_tb();

	logic clk, rst_n, en, WrEn;
	logic signed [7:0] Ain, Aout, Bin, Bout;
	logic signed [15:0] Cin, Cout, answer;
	
	tpumac DUT(
		.clk(clk),
		.rst_n(rst_n),
		.WrEn(WrEn),
		.en(en),
		.Ain(Ain),
		.Bin(Bin),
		.Cin(Cin),
		.Aout(Aout),
		.Bout(Bout),
		.Cout(Cout)
	);
	
	always #5 clk <= ~clk;
	
	initial begin
		rst_n = 0;
		clk = 0;
		Ain = 0;
		Bin = 0;
		Cin = 0;
		en = 0;
		WrEn = 0;
		@(negedge clk) rst_n = 1;

		for(integer i = 0; i < 100; i++) begin
			Cin = $random;
			en = 1;
			WrEn = 1;
			@(negedge clk)
			if(Cout != Cin) begin
				$display("Error when input Cin!");
				$stop;
			end
			WrEn = 0;
			for(integer i = 0; i < 100; i++) begin
				Ain = $random;
				Bin = $random;
				answer = Cout + Ain * Bin;
				@(negedge clk)
				if(Cout != answer) begin
					$display("Error at cycle %d, Cout is %d, expected %d!", i, Cout, answer);
					$stop;
				end
				if(Aout != Ain) begin
					$display("Error at cycle %d, Aout is %d, expected %d!", i, Aout, Ain);
					$stop;
				end
				if(Bout != Bin) begin
					$display("Error at cycle %d, Bout is %d, expected %d!", i, Bout, Bin);
					$stop;
				end
			end
		end
		
		$display("Yahoo!All test pass!!!");
		$stop;
	end
endmodule