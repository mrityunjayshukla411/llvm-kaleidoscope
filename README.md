# llvm-kaleidoscope

A compiler for the Kaleidoscope language, built by following the [LLVM tutorial](https://llvm.org/docs/tutorial/). Compiles Kaleidoscope source to native object code via LLVM IR.

## Features

- Arithmetic and comparison operators
- User-defined binary and unary operators
- `if/then/else`, `for/in` control flow
- Mutable variables via `var`
- Emits a native `.o` object file linkable from C/C++

## Project Structure

```
include/   headers (Lexer, AST, Parser, CodeGen)
src/       source files + main.cpp
bin/       compiled executable
obj/       intermediate object files
```

## Build

Requires LLVM 18 and clang++.
* Make
```bash
make        # produces bin/kal
make clean  # remove build artifacts
```

* CMake
```bash
cmake -S . -B build
cmake --build build # produces bin/kal
cmake --build build --target clean  # remove build artifacts
```

## Usage

Write a `.kal` file, compile it, then link against a C driver.

```bash
# 1. compile
bin/kal < program.kal        # writes output.o

# 2. link with a C driver
clang driver.c output.o -o myprog

# 3. run
./myprog
```

## Language Quick Reference

```
# function definition
def add(a b) a + b;

# extern declaration
extern sin(x);

# if/else
def abs(x) if x < 0 then -x else x;

# for loop
for i = 0, i < 10, 1.0 in printd(i);

# mutable variable
var x = 1 in x = x + 1;

# user-defined operator
def binary | 5 (a b) if a then 1 else if b then 1 else 0;
```

Built-in functions available via `extern`: `putchard(x)`, `printd(x)`.
