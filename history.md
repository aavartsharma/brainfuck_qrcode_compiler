cd tinycc
 1586  ./configure
 1587  make
 1588  sudo make install
 1589  tcc
 1590  cd 
 1591  cd Doc*/Vart*
 1592  cd ../bf
 1593  ls
 1594  tcc main.c
 1595  tcc main.c -o test
 1596  tcc -nostdlib -nostartfiles main.c -o app
 1597  tcc --nostdlib --nostartfiles main.c -o app
 1598  man tcc
 1599  tcc -nostdlib main.c -o app
 1600  ls -lh
 1601  ls
 1602  tcc -nostdlib main.c -o app
 1603  ls -lh
 1604  tcc -nostdlib main1.c -o app1
 1605  ls
 1606  ls -lh
 1607  11
 1608  tcc main1.c -o app1
 1609  ls -lh
 1610  ls
 1611  nasm test.asm
 1612  ls
 1613  size *
 1614  ls -lh
 1615  hexdump  -C app
 1616  nasm -f elf test.asm
 1617  cat test.asm >> test.S
 1618  nasm -f elf test.S
 1619  ls
 1620  ls | grep .o
 1621  nasm -f elf test.S
 1622  as
 1623  as test.S -o test.o
 1624  ld test.o -o bf
 1625  ls
 1626  ls -lh 
 1627  as --strip-local-absolute test.S -o test.o
 1628  ld -s -o bf test.o
 1629  ls -lh
 1630  ./a.out
 1631  sudo ./a.out
 1632  hexdump a.out
 1633  sudo apt install hexedit
 1634  hexedit app
 1635  hexedit bf
 1636  clear
 1637  objdump -h bf
 1638  ld -s -n --build-id=none -o bf test.o
 1639  ls -lh
 1640  strip bf
 1641  ls -lh
 1642  ld -N -s -o bf1 test.o
 1643  ls -lh
 1644  touch hello.bf
 1645  ./bf hello.bf
 1646  history 100
 1647  touch Makefile
 1648  ls
 1649  nvim
 1650  ls
 1651  cd Doc*
 1652  ls
 1653  cd bf
 1654  ls
 1655  ls -lh
 1656  xxd app1
 1657  hexdump -C app1
 1658  size app1
 1659  strip app1
 1660  ls
 1661  size app1
