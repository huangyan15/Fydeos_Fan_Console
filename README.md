# Fydeos_Fan_Console
ChromeBook安装成Fydeos之后，风扇、键盘背光无法控制，发现ectool本身是支持Linux使用的，写了脚本方便使用。
开启Linux子系统之后要安装一些依赖
apt install -y libftdi1 libusb-1.0-0
apt install -y libftdi1-dev libusb-1.0-0-dev
每次运行需要在root下执行，目前还没有找到合适的方案。
