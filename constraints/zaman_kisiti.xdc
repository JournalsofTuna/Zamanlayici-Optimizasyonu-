# ==========================================================
# 1. ZAMANLAMA KISITLAMASI (TIMING CONSTRAINT)
# ==========================================================
# Verilog kodunuzda saat portunun adı tam olarak 'clk' olduğu için 
# [get_ports clk] kullanıyoruz. 
# Hedef: 333 MHz (Periyot = 3.000 nanosaniye)
create_clock -period 3.390 -name sys_clk [get_ports clk]

# ==========================================================
# 2. BASYS 3 FİZİKSEL PIN TANIMLARI (ZORUNLU DEĞİL AMA ÖNERİLİR)
# ==========================================================
# Vivado'nun 'clk' portunu, Basys 3 kartındaki gerçek 100 MHz 
# osilatör pinine (W5) bağlamasını garanti altına almak için 
# bu iki satırı da ekliyoruz. Böylece "port bulunamadı" hatası 
# alma ihtimali sıfıra iner.
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# (Opsiyonel) Diğer portlarınız için de Basys 3 standartlarını 
# eklemek isterseniz implementasyon sırasında "Unspecified I/O Standard" 
# hatası almazsınız. Örnek:
# set_property PACKAGE_PIN V17 [get_ports rst_n]
# set_property IOSTANDARD LVCMOS33 [get_ports rst_n]