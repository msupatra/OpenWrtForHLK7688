#!/bin/bash

# 1. เปิดใช้งาน SPI0 โดยเปลี่ยนสถานะจาก disabled เป็น okay
sed -i 's/status = "disabled";/status = "okay";/g' target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts

# 2. ใช้คำสั่ง printf เขียนโค้ด SPI ต่อท้ายไฟล์โดยตรง (วิธีนี้จะไม่กวนโครงสร้างเดิมและไม่มี Syntax Error)
printf '\n&spi0 {\n\tspidev@1 {\n\t\tcompatible = "linux,spidev";\n\t\treg = <1>;\n\t\tspi-max-frequency = <1000000>;\n\t};\n};\n' >> target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts
