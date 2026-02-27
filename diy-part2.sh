#!/bin/bash

# 1. ค้นหาบรรทัด spi0 และเปลี่ยนสถานะจาก disabled เป็น okay ในไฟล์ DTS ของ HLK-7688A
sed -i '/&spi0 {/,/status = "disabled";/ s/status = "disabled";/status = "okay";/' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts

# 2. เพิ่มโหนด spidev@1 เข้าไปภายใต้ spi0 เพื่อให้เกิดไฟล์ /dev/spidev0.1
# คำสั่งนี้จะแทรกโหนดก่อนปิดปีกกาของ &spi0
sed -i '/&spi0 {/a \
\	spidev@1 {\
\		compatible = "linux,spidev";\
\		reg = <1>;\
\		spi-max-frequency = <1000000>;\
\	};' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts
