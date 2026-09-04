
module optimize_timer_v2(

    input wire clk,
    input wire rst_n,
    input wire enable,
    input wire load,
    input wire [31:0] target_val,
    output wire done // Artik 'reg' degil, kombinasyonel 'wire'

    );
    reg [31:0] count;
    
    // Done Sinyali artik kombinasyonel logic (assign ile) 
    // ~|count = : Tum bitler 0 ise 1 doner (NOR indirgeme operatoru) 
    assign done = (~|count); 
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 32'd0;
        end
        else if (load) begin
            count <= target_val;
         end
         else if (enable && (|count)) begin // count != ise azalt.
            count <= count - 32'd1;
         end
         // else: count korunur. (done zaten kombinasyonel) 
       end 
       
 // done artik wire oldu. assign done = (~|count); ile kombinasyonel logic yapildi. Bu, done icin bir flip flop gereksinimini ortadan kaldirir.
 // ~|count (NOR indirgeme): Bu Operator, Vivado'da "tum bitleri NOR'la" mesaji verir ve arac bunu optimize sekilde (2 seviye LUT) kurar.
 // |count (OR indirgeme): count !=0 kontrolu icin  kullanildi.
 
 


endmodule
