# Zamanlayici-Optimizasyonu-

# The Timer Project: Smart Coding with Logic Level Optimization

Bu Proje, FPGA tasarımlarında, **smart coding** tekniklerinin zamanlama(timing) performansını nasıl iyileştirdiğini göstermek için yapılmıştır.

# AMAÇ
Belirli Bir çevrim boyunca sayıp süresi dolunca "Done" sinyali veren bir zamanlayıcı (timer) devresi tasarlamak ve +200 MHz frekanslarda çalıştırmak.

# SORUN
Klasik yöntemde (yukarı sayma + dinamik karşılaştırma), 32-bit genişliğindeki sayaç ile hedef register'ın  karşılaştırılması, 
donanımda geniş bir XNOR + AND ağacı oluşturur.Bu yapı yüksek frekanslarda (400 MHz) **timing ihlali** yaratır.

# ÇÖZÜM
Tasarımı **aşağı sayma (geri sayım)** ve **sabit sıfır kontrolü** ile optimize etmek:
'count == target_val' (Dinamik vs Dinamik) **3-4 LUT Seviyesi**
'count == 0' (Dinamik ve Sabit)  **2 LUT Seviyesi**

# SONUÇLAR
1- 400 MHz'deki Zamanlayıcı (Timing) Durumu:
<img width="1182" height="267" alt="2851cbb5-9751-4a97-93aa-201a4c4285e2_image" src="https://github.com/user-attachments/assets/371edd3c-6a58-4f8f-987c-d43e6f70cf9e" />

2- 300 MHz'deki Zamanlayıcı (Timing) Durumu:
<img width="1077" height="267" alt="493cf751-0bf8-4f14-9a45-8783f61dd48f_image" src="https://github.com/user-attachments/assets/77d9dbc9-3596-415a-9e5d-d7f3de292318" />

3-290 MHz'deki Zamanlayıcı (Timing) Durumu:
<img width="1087" height="252" alt="469c9bb5-8602-4d1c-9b26-9f0080f9771b_image" src="https://github.com/user-attachments/assets/d60c2b58-2b0d-44d4-8012-88c4f8aeede9" />


