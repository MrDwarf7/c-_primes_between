CC=g++
WINCC=x86_64-w64-mingw32-g++
CFLAGS = -std=c++20 primes_between.cpp
WINFLAGS = -std=c++20 primes_between.cpp

all: linux win

linux:primes_between.cpp
	$(CC) $(CFLAGS) -o primes_between

win:primes_between.cpp
	$(WINCC) $(WINFLAGS) -o primes_between.exe

winperms:
	chmod 777 primes_between.exe
	chmod +x primes_between.exe

clean:
	rm -rf *.o primes_between primes_between.exe
