#!/bin/bash

CHARS=$(python -c 'print("\u2029".encode("utf8"))')
sed 's/['"$CHARS"']//g' < main.tex > main2.tex