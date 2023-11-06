#include "common.h"

.globl delay
delay:
    sub x0,x0,#1
    bne delay
    ret

.globl WriteRegister
WriteRegister:
    str w1, [x0]
    ret

.globl ReadRegister
ReadRegister:
    ldr w0, [x0]
    ret
