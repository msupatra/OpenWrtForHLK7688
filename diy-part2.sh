# 1. เปิดสถานะ SPI เป็น okay
sed -i 's/status = "disabled";/status = "okay";/g' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts

# 2. แทรก spidev@1 เข้าไปหลังบรรทัดที่มี status = "okay"; ภายในโหนด spi0 
# โดยใช้คำสั่งที่ระมัดระวังเรื่องลำดับ (ใช้ a เพื่อ append ต่อท้าย)
sed -i '/&spi0 {/,/};/ { /status = "okay";/ a \
	spidev@1 {\
		compatible = "linux,spidev";\
		reg = <1>;\
		spi-max-frequency = <1000000>;\
	};' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts
