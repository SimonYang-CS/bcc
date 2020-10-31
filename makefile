CF=-minline-all-stringops -fno-asynchronous-unwind-tables -fno-stack-protector -Wall -Wno-pointer-sign -Wno-strict-aliasing -Wno-parentheses -Wno-unused-value -Wno-misleading-indentation -Wno-unused-function
#LF=-nostdlib -c a.S
SRC=a.c b.c p.c
O=-O0 -g

ifeq ($(shell uname),Darwin)
 CF+= -pagezero_size 1000
endif

# llvm
l:
	clang $O $(LF) $(SRC) -o bl $(CF)
	./bl t.b

# gcc
g:
	gcc $O $(LF) $(SRC) -o bg $(CF)
	./bg t.b

# tcc
t:
	tcc -std=c99 $O $(SRC) -o bt
	./bt t.b

# ref
r:
	clang -Os -g r.c -o r&&./r
	@#objdump -d r

all: l g t

clean:
	@rm -f bl bg bt r
