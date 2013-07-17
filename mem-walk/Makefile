CFLAGS = -Wall -g
LDLIBS = -lpthread

.PHONY: all clean

all: mem-walk mem-walk-no-thrash mem-walk-no-thread mem-walk-no-thread-no-thrash

mem-walk: mem-walk.o

mem-walk.o: mem-walk.c
	$(CC) $(CFLAGS) -DTHRASH_CACHE=1 -c -o $@ $<

mem-walk-no-thrash: mem-walk-no-thrash.o

mem-walk-no-thrash.o: mem-walk.c
	$(CC) $(CFLAGS) -DTHRASH_CACHE=0 -c -o $@ $<

mem-walk-no-thread: mem-walk-no-thread.o

mem-walk-no-thread.o: mem-walk-no-thread.c
	$(CC) $(CFLAGS) -DTHRASH_CACHE=1 -c -o $@ $<

mem-walk-no-thread-no-thrash: mem-walk-no-thread-no-thrash.o

mem-walk-no-thread-no-thrash.o: mem-walk-no-thread.c
	$(CC) $(CFLAGS) -DTHRASH_CACHE=0 -c -o $@ $<

clean:
	-rm -f mem-walk mem-walk-no-thrash
	-rm -f mem-walk-no-thread mem-walk-no-thread-no-thrash
	-rm -f *.o *~
