@ Colin Sawyer (crsawye) Stanley Lam (stanlel)
@ CPSC 231 Section 2
@ Program 4
@ 11/13/17
@ Decoding and Encoding a character string using a secret key

.file "encode.s"
.global encode
.type   encode, %function
input .req r0             @input is input string name
output .req r1            @output is output string name
key .req r2               @key is the key string name
switch .req r3            @switch is the switch integer
inputIt .req r4           @inputIt is the iterator for the input string
keyIt .req r7             @keyIt is the iterator for the key string
inputEl .req r5           @inputEl is the current element of the input string
keyEl .req r6             @keyEl is the current element of the key string

encode:

  push {inputIt-keyIt, lr}          @initialize iterators
  mov inputIt, #0
  mov keyIt, #0

  cmp switch, #0                    @check switch for encode/decode
  bgt dloop

eloop:

  ldrb inputEl, [input, inputIt]    @load elements from input/key into registers
  ldrb keyEl, [key, keyIt]

  cmp keyEl, #0x0                   @branch to repeatKey1 if null char in key
  beq repeatKey1

  cmp inputEl, #0x0                 @branch to done if null char in input string
  beq done

  cmp inputEl, #0x20                @branch to storing if input is space
  beq store1

  cmp keyEl, #0x20                  @branch to store if the key has a space
  beq store1

  sub inputEl, inputEl, #0x60       @do the conversions to numbers and add them
  sub keyEl, keyEl, #0x60
  add inputEl, inputEl, keyEl

  cmp inputEl, #0x1a                @branch to fix the over 26 values
  bgt fixOverflow

  add inputEl, inputEl, #0x60

store1:

  strb inputEl, [output, inputIt]   @store the value in the output string
  add inputIt, inputIt, #1          @iterate to next element
  add keyIt, keyIt, #1
  bal eloop

repeatKey1:

  mov keyIt, #0                     @reset key iterator to restart the key index
  bal eloop

fixOverflow:

  sub inputEl, inputEl, #0x1a       @subtract 26 from the over-flowers
  add inputEl, inputEl, #0x60
  bal store1

dloop:

  ldrb inputEl, [input, inputIt]    @load elements from input/key into registers
  ldrb keyEl, [key, keyIt]

  cmp keyEl, #0x0                   @branch to repeatKey2 if null char in key
  beq repeatKey2

  cmp inputEl, #0x0                 @branch to done if null char in input string
  beq done

  cmp inputEl, #0x20                @branch to storing if input is a space
  beq store2

  cmp keyEl, #0x20                  @branch to store if the key has a space
  beq store2

  sub inputEl, inputEl, #0x60       @convert to numbers and subtract them
  sub keyEl, keyEl, #0x60
  sub inputEl, inputEl, keyEl

  cmp inputEl, #0                   @branch to fix the under 26 values
  ble fixUnderflow

  add inputEl, inputEl, #0x60

store2:

  strb inputEl, [output, inputIt]   @store the value in the output string
  add inputIt, inputIt, #1          @iterate to next element
  add keyIt, keyIt, #1
  bal dloop

repeatKey2:

  mov keyIt, #0                     @reset key iterator to reset the key index
  bal dloop

fixUnderflow:

  add inputEl, inputEl, #0x1a       @subtract 26 from the under-flowers
  add inputEl, inputEl, #0x60
  bal store2

done:

  strb inputEl, [output, inputIt]   @add null char to end of the output string
  pop {inputIt-keyIt, pc}
