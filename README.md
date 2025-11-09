# Fydeos_Fan_Console
ChromeBook安装成Fydeos之后，风扇、键盘背光无法控制，发现ectool本身是支持Linux使用的，写了脚本方便使用。  
开启Linux子系统之后要安装一些依赖，在Linux子系统中安装  
`apt install -y libftdi1 libusb-1.0-0`  
`apt install -y libftdi1-dev libusb-1.0-0-dev`  

在fydeos的终端中，将fydectl.sh脚本和ectool二进制文件放到`/usr/local/bin`下（路径可以自己修改）  
设置可执行脚本  
`sudo cp /usr/local/bin/fydectl.sh /usr/local/bin/fydectl`   
设置可执行权限  
`sudo chmod +x /usr/local/bin/fydectl`  
`sudo chmod +x /usr/local/bin/ectool`  

即使在非root下也可以执行了  
fydectl  
