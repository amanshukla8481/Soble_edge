 module canny_edge(
    input clk, reset, start,
    input wire [15:0] px11, px21, px31, px12, px22, px32, px13, px23, px33,
    output wire [15:0] dx_out, dy_out, dxy,
    output wire dx_outsign, dy_outsign
);

 

wire temp3x_sign;
wire [15:0] temp1x, temp2x, temp3x;
wire temp3y_sign;
wire [15:0] temp1y, temp2y, temp3y;
reg data_occur =0;
wire [15:0] reg_add;
reg [15:0] px11t, px21t, px31t, px12t, px22t, px32t, px13t, px23t, px33t;

initial begin
    px11t = 16'b0;
    px21t = 16'b0;
    px31t = 16'b0;
    px12t = 16'b0;
    px22t = 16'b0;
    px32t = 16'b0;
    px13t = 16'b0;
    px23t = 16'b0;
    px33t = 16'b0;
end

// Gradient Computation
assign dy_out = temp3y;
assign dx_out = temp3x;

assign temp1x = (px11t + (px21t << 1) + px31t);
assign temp2x = (px13t + (px23t << 1) + px33t);
assign temp3x = (temp1x > temp2x) ? (temp1x - temp2x) :
                (temp1x < temp2x) ? (temp2x - temp1x) : 16'd0;
assign dx_outsign = (temp1x > temp2x) ? 1'b1 : 1'b0;

assign temp1y = (px11t + (px12t << 1) + px13t);
assign temp2y = (px31t + (px32t << 1) + px33t);
assign temp3y = (temp1y > temp2y) ? (temp1y - temp2y) :
                (temp1y < temp2y) ? (temp2y - temp1y) : 16'd0;
assign dy_outsign = (temp1y > temp2y) ? 1'b1 : 1'b0;

assign reg_add = (data_occur) ? (dx_out + dy_out) : 16'd0;
assign dxy = (data_occur && reg_add >= 16'd255) ? 16'd255 : 16'd0;

// Always block for updating pixel registers
always @(posedge clk) begin
    if (~reset) begin
        px11t <= 16'b0; px12t <= 16'b0; px13t <= 16'b0;
        px21t <= 16'b0; px22t <= 16'b0; px23t <= 16'b0;
        px31t <= 16'b0; px32t <= 16'b0; px33t <= 16'b0;
        data_occur <= 1'b0;
    end else if (start) begin
        px11t <= px11; px12t <= px12; px13t <= px13;
        px21t <= px21; px22t <= px22; px23t <= px23;
        px31t <= px31; px32t <= px32; px33t <= px33;
        data_occur <= 1'b1;
    end
end

endmodule
