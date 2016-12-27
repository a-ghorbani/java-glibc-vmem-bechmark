#!/bin/bash


# ./mem.sh -c "java -Xmx100M Main" -o Thread-01__Default
./mem.sh -c "java -Xmx100M MainMT" -o Thread-32__Default

export MALLOC_ARENA_MAX=1

# ./mem.sh -c "java -Xmx100M  Main" -o Thread-01__ARENA-MAX-01
./mem.sh -c "java -Xmx100M MainMT" -o Thread-32__ARENA-MAX-01

export MALLOC_ARENA_MAX=15

# ./mem.sh -c "java -Xmx100M  Main" -o Thread-01__ARENA-MAX-15
./mem.sh -c "java -Xmx100M MainMT" -o Thread-32__ARENA-MAX-15

# export MALLOC_ARENA_MAX=20
# 
# ./mem.sh -c "java -Xmx100M  Main" -o Thread-01__ARENA-MAX-20
# ./mem.sh -c "java -Xmx100M MainMT" -o Thread-32__ARENA-MAX-20

Rscript script.R Thread-32__Default,Thread-32__ARENA-MAX-01,Thread-32__ARENA-MAX-15 plot_mems.png
                                                                                                                                                


