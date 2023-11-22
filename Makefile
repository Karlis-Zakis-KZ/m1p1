TARGET=m1p1

all:
	arm-linux-gnueabi-gcc -o $(TARGET) main.c m1p1.s
