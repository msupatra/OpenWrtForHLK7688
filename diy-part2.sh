# ลบบรรทัดที่ซ้ำซ้อนออกและใช้เพียงชุดนี้
sed -i 's/status = "disabled";/status = "okay";/g' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts

sed -i '/spi0 {/,/};/ s/status = "okay";/status = "okay";\n\tspidev@1 {\n\t\tcompatible = "linux,spidev";\n\t\treg = <1>;\n\t\tspi-max-frequency = <1000000>;\n\t};/' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts
