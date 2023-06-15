/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/

 
void* memcpy(void* restrict dstptr, const void* restrict srcptr, size_t size) {
	unsigned char * dst = (unsigned char *) dstptr;
	const unsigned char * src = (const unsigned char *) srcptr;
	for (size_t i = 0; i < size; i++)
		dst[i] = src[i];
	return dstptr;
}