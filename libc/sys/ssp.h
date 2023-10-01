#ifndef _STDINT_H
#include <stdint.h>
#endif

#if UINT32_MAX == UINTPTR_MAX
#define STACK_CHK_GUARD 0xe2dee396
#else
#define STACK_CHK_GUARD 0x595e9fbd94fda766
#endif
 
uintptr_t __stack_chk_guard = STACK_CHK_GUARD;
 
__attribute__((noreturn)) void __stack_chk_fail(void) {
	#if __STDC_HOSTED__
		abort();
	#elif __blueberry__
		panic("__stack_chk_fail called","Stack smashing detected",1);
	#endif
}