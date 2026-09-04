
// Modul Tanim baslangici, devre ismi = classic_timer
module classic_timer(

// 'clk': Sistemin kalbi olan saat sinyali girisi (orn:200MHz), Tum Flip-Flop'lar bu sinyalin yukselen kenarinda tetiklenir.
input wire clk,
// 'rst_n': Aktif dusuk(active-low) sifirlama sinyali. Ismindaki '_n' takisi, bu sinyalin '0' oldugunda reset atacagini belirtir.
input wire rst_n,
// 'enable': sayacin saymayi baslayip durmasini kontrol eden dis tetikleme sinyali 1 ise sayar, 0 ise durur.
input wire enable,
// 'target val': Hedef sayim degeri. 32-bit genisliginde bir wire'dir. Disaridan dinamik olarak degistirilebilir.
input wire [31:0] target_val,
// 'done': Sayim hedefine ulastiginda disariya '1' (lojik high) olarak verilen cikis sinyali.
output reg done

    );
    
    // 'count' iceride tutulan 32-bitlik sayac degeri. Degeri clock kenarinda saklayacagi icin 'reg' (register/yazmac) olarak tanimlanir.
    reg [31:0] count;
    
    // 'always' blogu: Bu blogun icindeki islemler, 'clk'nin yukselen kenarinda (posedge) VEYA 'rst_n'nin dusen kenarinda(negedge)  tetiklenir.
    // Bu yapiya "asenkron reset'li senkron tasarim" denir ve FPGA'lerde en guvenilir yontemdir.
    always @(posedge clk or negedge rst_n) begin
    
    // Oncelik 1: Reset Durumu
    // Eger reset sinyali '0' ise (aktif), tum kayitlari (register) guvenli baslangic degerlerine sifirla.
    if(!rst_n) begin
    count <= 32'd0; // Sayaci 32-bit genisliginde desimal(ondalik) '0' degerine esitle.
    done <= 1'b0; // 'done' sinyalini 1-bit genisliginde binary '0' degerine esitle.
  end
  
  // Oncelik 2: Sayma Izni Durumu
  // Reset yoksa ve 'enable' sinyali '1' ise sayma islemine izin ver.
  else if (enable) begin
  
      // Alt Kosul: Hedefe Ulasma Kontrolu
      // Eger mevcud sayac degeri, disaridan gelen hedef degere esitse:
      if(count == target_val) begin
      count <= 32'd0; // Sayaci bir sonraki dongu icin tekrar sifirla (periyodik sayim icin)
      done <= 1'b1;  // Sure doldugunu belirtmek icin 'done' cikisini '1' yap.
      end
      
     // Alt Kosul: Hedefe Henuz Ulasilmadi
     // Eger sayac hedef degere esit degilse:
     else begin
        count <= count + 32'd1; // Sayacın mevcut değerine 1 ekle ve bir sonraki clock'ta bu yeni değeri kaydet.
        done <= 1'b0; // Hedefe henuz varilmadigi icin 'done' sinyalini  '0' olarak koru.
      end
   end

    // Oncelik 3: Sayma Izni Yok (Enable = 0) 
    // Eger 'enable' sinyali '0' ise, sayac ve done sinyali mevcud degerlerini korumalidir.
    else begin
    count <= count; // Sayacin degerini degistirme (Mevcud degeri kendisine ata)
    done <= done;  // 'done' sinyalinin durumunu degistirme.
  end
end

// Modul Taniminin sonu

 
endmodule


