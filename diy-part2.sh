#!/bin/bash

# สร้างไฟล์ DTS ใหม่ทับตัวเดิม เพื่อเปิด SPI และแก้ปัญหาโครงสร้างไฟล์
cat <<EOF > target/linux/ramips/dts/mt7628an_hilink_hlk-7688a.dts
/dts-v1/;

#include "mt7628an.dtsi"
#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/input/input.h>

/ {
	compatible = "hilink,hlk-7688a", "mediatek,mt7628an-soc";
	model = "HiLink HLK-7688A";

	aliases {
		label-mac-device = &ethernet;
	};

	chosen {
		bootargs = "console=ttyS0,115200";
	};
};

&state_default {
	gpio {
		groups = "p0led", "p1led", "p2led", "p3led", "p4led", "wdt", "wled_an";
		function = "gpio";
	};
};

&spi0 {
	status = "okay";

	spidev@1 {
		compatible = "linux,spidev";
		reg = <1>;
		spi-max-frequency = <1000000>;
	};
};

&ethernet {
	mtd-mac-address = <&factory 0x28>;
};

&wmac {
	status = "okay";
};
EOF
