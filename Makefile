TARGET=m1p1

all:
	arm-linux-gnueabi-gcc -o $(TARGET) $(TARGET).c m1p1.s
