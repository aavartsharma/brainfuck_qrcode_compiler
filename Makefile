all: compile/as

compile/as: 
	as --strip-local-absolute bf.asm -o bf.o
	ld -N -s -o bf bf.o

