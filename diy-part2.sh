#!/bin/bash

# 1. เปลี่ยนสถานะ spi0 จาก disabled เป็น okay
sed -i 's/status = "disabled";/status = "okay";/g' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts

# 2. แก้ปัญหา Properties must precede subnodes โดยการแทรก spidev ไว้หลังสุดของก้อน spi0
# เราจะหาบรรทัด 'status = "okay";' ที่อยู่ภายในโหนด spi0 แล้วแทนที่ด้วยตัวมันเองตามด้วย subnode
sed -i '/&spi0 {/,/};/ s/status = "okay";/status = "okay";\n\n\tspidev@1 {\n\t\tcompatible = "linux,spidev";\n\t\treg = <1>;\n\t\tspi-max-frequency = <1000000>;\n\t};/' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts
