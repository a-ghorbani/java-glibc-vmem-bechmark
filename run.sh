#!/bin/bash


./mem.sh -c "java -Xmx100M Main" -o mem_Xmx100M_ST.csv
./mem.sh -c "java -Xmx100M MainMT" -o mem_Xmx100M_MT.csv

export MALLOC_ARENA_MAX=1

./mem.sh -c "java -Xmx100M  Main" -o mem_Xmx100M_ST_ARENA01.csv
./mem.sh -c "java -Xmx100M MainMT" -o mem_Xmx100M_MT_ARENA01.csv

export MALLOC_ARENA_MAX=16

./mem.sh -c "java -Xmx100M  Main" -o mem_Xmx100M_ST_ARENA16.csv
./mem.sh -c "java -Xmx100M MainMT" -o mem_Xmx100M_MT_ARENA16.csv

export MALLOC_ARENA_MAX=32

./mem.sh -c "java -Xmx100M  Main" -o mem_Xmx100M_ST_ARENA32.csv
./mem.sh -c "java -Xmx100M MainMT" -o mem_Xmx100M_MT_ARENA32.csv

Rscript script.R mem_Xmx100M_ST.csv,mem_Xmx100M_MT.csv,mem_Xmx100M_ST_ARENA01.csv,mem_Xmx100M_MT_ARENA01.csv,mem_Xmx100M_ST_ARENA16.csv,mem_Xmx100M_MT_ARENA16.csv,mem_Xmx100M_ST_ARENA32.csv,mem_Xmx100M_MT_ARENA32.csv plot_mems.png
                                                                                                                                                


