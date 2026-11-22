# TUKU

TUKU is a Termux-first coding toolkit for Android.

It provides command-line helpers for compiling C, C++, and C# source files, managing optional packages, and configuring a comfortable Termux environment.

The repository also includes a GitHub Actions workflow that builds a Debian `.deb` package. Debian is an additional distribution target; Termux remains the primary target.

## Features

- Compile C with Clang or GCC.
- Compile C++ with Clang++ or G++.
- Compile C# when dotnet or csc is available.
- Use `tuku compile FILE` to select a compiler automatically.
- Install locally in Termux without root.
- Build Debian packages through GitHub Actions.

## Requirements

- Android with Termux.
- Bash, Git, and Clang for C/C++.
- C# support is optional.

Install basic tools:

```bash
pkg update
pkg install git bash clang
