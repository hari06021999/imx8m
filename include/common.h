#include <stdint.h>

typedef volatile uint32_t Reg32_t;

#pragma once

void WriteRegister(unsigned long address, unsigned int value);
unsigned int ReadRegister(unsigned long address);
void delay(unsigned long value);