CC=g++
WINCC=x86_64-w64-mingw32-g++
CFLAGS=-std=c++20

LINUX_REMOVE=rm -rf *.o
WIN_REMOVE=pwsh -c Remove-Item -Recurse -Force

LINUX_OUTPUT=primes_between
WINDOWS_OUTPUT=primes_between.exe

FILES_LIST=primes_between.cpp

# Detect OS
ifeq ($(OS),Windows_NT)
	detected_OS=Windows
else
	detected_OS=$(shell uname -s)
endif

# Set OS-specific flags
CFLAGS += $(if $(findstring Windows,$(detected_OS)),-D WIN32,\
			$(if $(findstring Darwin,$(detected_OS)),-D OSX,\
			$(if $(findstring Linux,$(detected_OS)),-D LINUX,\
			$(if $(findstring GNU,$(detected_OS)),-D GNU_HURD,\
			$(if $(findstring FreeBSD,$(detected_OS)),-D FreeBSD,\
			$(if $(findstring NetBSD,$(detected_OS)),-D NetBSD,\
			$(if $(findstring DragonFly,$(detected_OS)),-D DragonFly,\
			$(if $(findstring Haiku,$(detected_OS)),-D Haiku))))))))

linux_build:
	@$(CC) $(CFLAGS) -o $(LINUX_OUTPUT) $(FILES_LIST)

windows_build:
	@$(WINCC) $(CFLAGS) -o $(WINDOWS_OUTPUT) $(FILES_LIST)

all:
	@echo Detected OS: $(detected_OS)
	ifeq ($(detected_OS), Linux) then \
		echo "Compiling for Linux and Windows..."; \
		$(MAKE) linux_build; \
		$(MAKE) windows_build; \
	else \
		echo "Compiling for $(detected_OS)..."; \
		$(MAKE) windows_build; \
	fi

clean:
	@echo Detected OS: $(detected_OS)
ifeq ($(detected_OS),Windows)
	pwsh -Command "if (Test-Path $(WINDOWS_OUTPUT)) { Remove-Item $(WINDOWS_OUTPUT) -Force }"
else
	@$(LINUX_REMOVE) $(LINUX_OUTPUT) 2>/dev/null || true
	@$(WIN_REMOVE) $(WINDOWS_OUTPUT) 2>/dev/null || true
endif
