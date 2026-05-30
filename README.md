# BrainFuck_QRcode_Compiler

This project contains a simple BrainFuck compiler written in c and x86 assembly which could be stored in a QR codeThe compiler reads Brainfuck code from a file and executes it. Brainfuck is an esoteric programming language created in 1993 by Urban Müller. It is known for its minimalistic design, consisting of only eight commands making it a Turing-complete language. + - < > . , [ ]

## Brainfuck Language

Brainfuck is a minimalist programming language consisting of only eight commands:

- `>`: Increment the data pointer.
- `<`: Decrement the data pointer.
- `+`: Increment the byte at the data pointer.
- `-`: Decrement the byte at the data pointer.
- `.`: Output the byte at the data pointer.
- `,`: Input a byte and store it at the data pointer.
- `[`: Jump past the matching `]` if the byte at the data pointer is zero.
- `]`: Jump back to the matching `[` if the byte at the data pointer is nonzero.

## QR Code for the compiler
scanning this qrcode on any linux distributation while give a brainfuck compiler excuatable which could be ran in terminal

![Brainfuck compiler](qr.png)
----
### NOTE 
doesn't work on IOS, Andriod, Microslop windows, openBSD

## Excution
1. **Scan the QR code:**
    
   ```sh
   zbarimg --oneshot -Sbinary --raw qr.png > ./bf
   ```
2. **Change file permissions:**

   ```sh
   chmod +x ./bf
   ```
3. **Excute the command:**
   ```sh
   ./bf [file]
   ```

## Inperation
  youtube:
  - ![veritasium's Video on QR code](https://youtu.be/w5ebcowAJD8?si=XXRY29oiKvwoq3mA)
  - ![fireship's Video on BrainFuck](https://youtu.be/hdHjjBS4cs8?si=vobD3_Gy9NlMLFo8)
  - ![MattKC's Video on snake in QR code](https://youtu.be/ExwqNreocpg?si=aPIiYo3DJ80QICAi)

## Compileation
1. **Genrate Object file from bf.asm:**
   ```sh
   as --strip-local-absolutte bf1.asm -o bf.o
   ```
2. **Create excutable file for bf.o**
   ```sh
   ld -N -s -o bf bf.o
   ```
## tips
if you want you convert bf code into Qr code

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
