module canny_test;

    reg clk = 0;
    reg reset = 0;
    reg start = 0;

    reg [15:0] px11, px12, px13;
    reg [15:0] px21, px22, px23;
    reg [15:0] px31, px32, px33;

    wire [15:0] dx_out;
    wire dx_outsign;
    wire [15:0] dy_out;
    wire dy_outsign;
    wire [15:0] dxy;
	 
	// integer write_count = 0;
	 integer i;

    reg [8:0] mem[0:589823];
    integer file_id, k;

    // Instantiate the module under test
    canny_edge uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .px11(px11), .px12(px12), .px13(px13),
        .px21(px21), .px22(px22), .px23(px23),
        .px31(px31), .px32(px32), .px33(px33),
        .dx_out(dx_out),
        .dx_outsign(dx_outsign),
        .dy_out(dy_out),
        .dy_outsign(dy_outsign),
        .dxy(dxy)
    );

    // Clock generation
     
    always #10 clk = ~clk;

    // Initialization
    initial begin
        reset = 0;
        start = 0;

        // Zero-initialize all pixel inputs
        px11 = 0; px12 = 0; px13 = 0;
        px21 = 0; px22 = 0; px23 = 0;
        px31 = 0; px32 = 0; px33 = 0;
		   #20 ;

        // Load memory from file (make sure input.txt is in the same folder)
     //  $readmemh("C:\intelFPGA_lite\canny_edge\simulation\modelsim\input.txt", mem);
	   for (i = 0; i <= 589823; i = i + 1) begin
                 mem[i] = 16'd0;
              end
		  
		  $readmemh("C:/intelFPGA_lite/canny_edge/simulation/modelsim/input.txt", mem);


        // Open file for writing
        file_id = $fopen("output.txt", "w");

        // Apply reset
        #20 reset = 1;
		  
		 
         
             
        

        // Main loop
        for (k = 0; k < 589824; k = k + 9) begin
            @(negedge clk)
            start = 1;
				#20;

            px11 = mem[k+0]; px12 = mem[k+3]; px13 = mem[k+6];
            px21 = mem[k+1]; px22 = mem[k+4]; px23 = mem[k+7];
            px31 = mem[k+2]; px32 = mem[k+5]; px33 = mem[k+8];
				
				 $display("mem[%0d] = %h", k, mem[k]);

            @(negedge clk)
            start = 0;

            @(negedge clk)
            if (uut.data_occur) begin
				     $fwrite(file_id, "%0d ", dxy);
                 //write_count = write_count + 1;

//               if (write_count == 9) begin
//                  $fwrite(file_id, "\n");
//                   write_count = 0;
//            end
//                $fwrite(file_id, "%h %h %h %h %h %h %h %h %h\n", 
//    px11, px12, px13, 
//    px21, px22, px23, 
//    px31, px32, px33);
               // $display("dxy = %d", dxy);
					 
            end
        end

        $fclose(file_id);
        $finish;
    end

endmodule
