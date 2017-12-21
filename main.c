#include <stdio.h>
#include <string.h>

void encode(char [], char [], char [], int);

int main()
{
   char str1[60] = "this is a test of the encoding algorithm";
   char str2[60] = "to be or not to be that is the question";
   char str3[60] = "a short phrase";

   char key1[35] = "a sample key";

   char e[60];
   char d[60];

   printf("\nTesting key:  a sample key\n");
   printf("---------------------------\n");
   printf("original :  %s\n", str1);
   encode(str1, e, key1, 0);
   printf("encrypted:  %s\n", e);
   encode(e, d, key1, 1);
   printf("decrypted:  %s\n", d);

   printf("\nTesting key:  a sample key\n");
   printf("---------------------------\n");
   printf("original :  %s\n", str2);
   encode(str2, e, key1, 0);
   printf("encrypted:  %s\n", e);
   encode(e, d, key1, 1);
   printf("decrypted:  %s\n", d);

   printf("\nTesting key:  a sample key\n");
   printf("---------------------------\n");
   printf("original :  %s\n", str3);
   encode(str3, e, key1, 0);
   printf("encrypted:  %s\n", e);
   encode(e, d, key1, 1);
   printf("decrypted:  %s\n", d);


   return 0;
}
