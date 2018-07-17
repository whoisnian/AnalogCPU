# AnalogCPU
8位模型机（数字电子课程设计）  

## 基本信息
* **课程设计名称：** 基于8位模型机的汇编指令执行模拟  
* **课程设计概述：** 在PC上通过C语言程序将汇编指令转换为二进制操作码，模拟汇编语言的编译过程，然后使用Windows的API通过串口通信将指令数据发送到FPGA开发板，开发板接收并写入数据到存储器中，最后8位模拟CPU从存储器中取数据，译码，执行指令，并显示结果。  
* **软件：** Quartus Prime Lite 18.0.0，CodeBlocks 17.12  
* **硬件：** 黑金FPGA开发板 ALINX ALTERA AX301（芯片为EP4CE6F17C8N）  

## 基本结构
![AnalogCPU](images/AnalogCPU.svg)  

## 指令系统
|   汇编指令   | 二进制操作码 |        功能说明        |
| ------------ | ------------ | ---------------------- |
| mov ax \<num\> | 00000001     | 向 ax 中存入立即数     |
| mov bx \<num\> | 00000010     | 向 bx 中存入立即数     |
| mov ax bx    | 00000011     | 将 bx 内容复制进 ax 中 |
| mov bx ax    | 00000100     | 将 ax 内容复制进 bx 中 |
| add ax \<num\> | 00000101     | 向 ax 中加上立即数     |
| add bx \<num\> | 00000110     | 向 bx 中加上立即数     |
| add ax bx    | 00000111     | 将 bx 加到 ax 中       |
| add bx ax    | 00001000     | 将 ax 加到 bx 中       |
| shr ax       | 00001001     | 将 ax 右移一位         |
| shr bx       | 00001010     | 将 bx 右移一位         |
| shl ax       | 00001011     | 将 ax 左移一位         |
| shl bx       | 00001100     | 将 bx 左移一位         |
| xchg         | 00001101     | 交换 ax 和 bx 的内容   |
| halt         | 00001110     | 停机                   |

## 文件说明
* `input_FOR_DEBUG`目录下为输入模块仿真部分。
* `input`目录下为输入模块下载测试部分，已添加数码管显示模块，可在下载到FPGA开发板上后使用串口调试工具（例如[https://github.com/0xE8551CCB/serial-assistant](https://github.com/0xE8551CCB/serial-assistant)进行测试。注意使用串口进行通信前需要安装驱动。
* `AnalogCPU_FOR_DEBUG`目录下为CPU模块仿真部分，无数据接收模块与数码管显示模块。
* `AnalogCPU`目录下为最终CPU模块、数据接收模块和数码管显示模块整合结果，可下载到开发板上进行测试。
* `AnalogCPU.c`为C语言调用Windows的API进行串口通信的程序，同时实现了汇编指令到二进制操作码的转换。
* `images`目录下为各个模块结构图，使用[https://www.draw.io](https://www.draw.io)作图，可打开xml文件进行编辑。

## 参考资料
* 《逻辑与数字系统设计》李晶皎，李景宏，曹阳，清华大学出版社。  
* 《FPGA/CPLD 边练边学——快速入门 Verilog/VHDL》吴厚航，北京航空航天大学出版社。  
* 《数字逻辑与数字系统（第四版）》李景宏，王永军，电子工业出版社。  