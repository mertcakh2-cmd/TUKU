#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: Compile-c#.sh <source.cs>"
    exit 2
fi

SOURCE="$1"

if [[ ! -f "$SOURCE" ]]; then
    echo "File not found: $SOURCE"
    exit 1
fi

if command -v csc >/dev/null 2>&1; then

    OUTPUT="${SOURCE%.*}.exe"

    echo "TUKU: csc -> $SOURCE"

    csc -out:"$OUTPUT" "$SOURCE"

    echo "Built: $OUTPUT"

elif command -v dotnet >/dev/null 2>&1; then

    if compgen -G '*.csproj' >/dev/null; then
        echo "Building .NET project..."
        dotnet build
    else
        echo "A .NET SDK is installed, but no .csproj was found."
        echo "Create a .NET console project and add your source file."
        exit 2
    fi

else

    echo "No C# compiler found."
    echo "Install a compatible .NET SDK or csc compiler."
    echo "C# support is optional in Termux."

    exit 127

fi
