all: 

compile/as: 
	as --strip-local-absolute test.S -o test.o
	ld -N -s -o bf3 test.o
	ls -lh | grep 

compile/nasm:
	nasm test.S
