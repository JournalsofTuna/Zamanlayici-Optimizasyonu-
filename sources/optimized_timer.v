// Module tanimi Optimize edilmis zamanlayici

module optimized_timer(

    input wire clk, // Saat Sinyali (Hedef: 400 MHz)
    input wire rst_n, // Aktif dusuk sifirlama
    input wire enable, // Sayaci baslatan/durduran sinyal
    input wire load, // Hedef degeri sayaca  yuklemek icin sinyal
    input wire [31:0] target_val, // Hedef sayim degeri (Yuklenecek deger)
    output reg  done    //  Sure doldugunda 1 olan cikti sinyali

    );
    
    // 1.SAYAC (COUNTER) TANIMI
    reg [31:0]  count;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        count <= 32'd0; // Reset atildiginda sayaci sifirla.
        done <= 1'b0; // Done Sinyalini sifirla.
      end
    else if(load) begin
         // Yukleme Asamasi: Hedef degeri sayaca yukle ve asagi saymaya basla.
         count <= target_val; 
         done <= 1'b0;
     end
     else if(enable) begin
        // ASAGI SAYMA ASAMASI
        // Eger sayac zaten 0 degilse, 1 azalt.
        if (count != 32'd0) begin
            count <= count - 32'd1; // Sayaci 1 azalt. (Geri sayim)
            done <= 1'b0; // Henuz bitmedi.
         end
         // Eger Sayac 0'a ulastiysa
         else begin
             count <= 32'd0; // Sayaci 0'da tut .
             done <= 1'b1; // Sure doldu, Done sinyalini aktif yap.
         end
      end
      else begin
            // Enable 0 ise degerleri koru.
            count <= count;
            done  <= done;
         end
       end
       
endmodule

// Neden Daha Optimize? 
// if (count ! = 32'd0) ve if(count == 32'd0)
// count = target_val islemi, 32 adet XNOR kapisi ve ardindan devasa bir AND agaci gerektirir. Bu, 3 veya 4 seviye LUT gecikmesi yaratır.
// Bir sayinin sifir olup olmadigini kontrol etmek (count == 0) tum bitlerin '0' olup olmadigini kontrol etmektir. Donanimda bu, XNOR kullanmadan,dogrudan tum bitleri birlestiren bir OR agaci(veya NOR) ile yapilir.
// 1) Sentez araci, 32-bitlik bir OR  agacini cok daha verimli, 2 Seviye (hatta bazen 1 seviye) LUT kullanarak kurulabilir.
// Mantik derinligi (Logic Levels) azaldigi icin, sinyalin kat etmesi gereken fiziksel yol kisalir gecikme duser.

