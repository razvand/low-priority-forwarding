/*
 * Put the cache on one core to use.
 *
 * Write values of 1 in 100 MB of data and then increment each byte.
 * If THRASH_CACHE macro is set, jump each CACHE_LINE_SIZE bytes in order
 * to thrash the cache. Otherwise go walk lineary through the memory array.
 *
 * Run once in order to fill the buffer cache. The buffer cache should be
 * "filled" in subsequent runs.
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define SIZE_IN_MB		100
#define NUM_ROUNDS		10
#define CACHE_LINE_SIZE		64
#define NUM_CHUNKS(x)		(sizeof(x) / sizeof(x[0]) / CACHE_LINE_SIZE)

/*
 * Memory array of 100 MB filled with zeros.
 * Allocated inside the executable file due to its presence in the data
 * memory zone. It should be stored in the buffer cache after a first run.
 */
static unsigned char mem[1024 * 1024 * SIZE_IN_MB] = {1, };

int main(void)
{
	size_t n, i;

#if THRASH_CACHE
	size_t j;

	for (n = 0; n < NUM_ROUNDS; n++)
		for (i = 0; i < CACHE_LINE_SIZE; i++)
			for (j = 0; j < NUM_CHUNKS(mem); j++)
				mem[j*CACHE_LINE_SIZE + i]++;
#else
	for (n = 0; n < NUM_ROUNDS; n++)
		for (i = 0; i < sizeof(mem)/sizeof(mem[0]); i++)
			mem[i]++;
#endif

	return 0;
}
