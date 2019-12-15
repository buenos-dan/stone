#drizzle operate system

#development

## install bochs using binary file

* download bochs's binary file from web
* tar zxvf bochs-2.6.10.tar.gz
* ./configure --prefix=/home/buenos/drizzle_os/bochs \    #install directory
	      --enable-debugger \                         #bochs debugger
	      --enable-disasm \                           #support dis asm
	      --enable-iodebug \                          #using io debugger
	      --enable-x86-debugger \			  #support x86 debugger
	      --with-x \                                  #using x windows
	      --with-x11                                  #using x11 graphic
* make
* make install

## config bochs
* vim bochsrc.disk
* ....

## 开机的过程描述(物理地址前1M都是BIOS的内存地址)
1. 上电时cs,ip被初始化为0xf000,0xfff0.即程序从0xffff0处开始运行.
2. 0xffff0处是一条跳转指令:jump far f000:e05b;
3. 0xfe05b是BIOS真正开始执行的地址.在此处，BIOS检查内存，显卡等外设信息
  ，当检测通过并初始化好硬件后，开始在内存中,0x000~0x3ff处建立数据结构，
  中断向量表IVT并填写中断例程。
4. BIOS最后的一项工作是检查启动盘中0盘0道1扇区到内容，如果最后两个字节是
  0x55 0xaa,BIOS则认为该扇区中确实存在可执行程序MBR，便将该扇区加载到0x7c00,
  随后跳转到此地址继续执行.
5. vim mbr.s 写一点代码 
6. nasm -o mbr.bin mbr.s
7. dd if=/yourpath/mbr.bin of=/yourpath/hd30M.img bs=512 count=1 conv=notrunc
8. ./bin/bochs -f bochsrc.disk -q
9. 即可看到自己写的代码到效果了.



## !!!学到这里，很多代码看不懂，决定先压栈，去学nasm
## gdb 的使用教程
* 参考./doc/GDB_tutorial.md


# nasm 编译链接并执行
* nasm -f elf64 -g -F stabs foo.s
* ld -o foo foo.o
* ./foo |  gdb foo
* 在.vimrc中定义了asmldrun 用来编译链接并执行

##INT10H系统调用
保护模式下不可用
* 参考./doc/INT10H.md













