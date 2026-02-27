#!/bin/bash

# 1. ค้นหาไฟล์ DTS ของ HLK-7688A และเปิดใช้งาน SPI0
# โดยการเปลี่ยนสถานะจาก disabled เป็น okay
sed -i 's/status = "disabled";/status = "okay";/g' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts

# 2. แทรกโครงสร้าง spidev@1 เข้าไปก่อนเครื่องหมายปีกกาปิดตัวสุดท้ายของไฟล์
# วิธีนี้จะปลอดภัยที่สุดเพราะไม่ไปขวางลำดับ Property เดิมที่ทำให้เกิด Error "Properties must precede subnodes"
sed -i '$i \
&spi0 {\
	spidev@1 {\
		compatible = "linux,spidev";\
		reg = <1>;\
		spi-max-frequency = <1000000>;\
	};\
};' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts
