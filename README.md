# encode_ARM
encodes a message in ARM assembly by adding character values of a message and a "key" together

This program works with changing values in registers in a subroutine and then returning those values back to the main function.  In main, there are a few strings of text each placed in char arrays.  Every time the ARM program is called, it takes four arguments: the input string that will be encoded/decoded, the output string, 
