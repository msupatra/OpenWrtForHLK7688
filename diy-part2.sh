#!/bin/bash

# 1. ค้นหาและเปลี่ยนสถานะ spi0 จาก disabled เป็น okay
sed -i 's/status = "disabled";/status = "okay";/g' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts

# 2. ใช้เทคนิคแทรก spidev@1 ไว้ก่อนเครื่องหมายปีกกาปิดตัวสุดท้ายของก้อน &spi0
# วิธีนี้จะรับประกันว่า spidev จะอยู่หลัง Property ทุกตัวแน่นอน
sed -i '/&spi0 {/,/};/ { /};/ i \
\	spidev@1 {\
\		compatible = "linux,spidev";\
\		reg = <1>;\
\		spi-max-frequency = <1000000>;\
\	};' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts
