TARGET=m1p1

all:
	arm-linux-gnueabi-gcc -o $(TARGET) $(TARGET).c matmul.s
