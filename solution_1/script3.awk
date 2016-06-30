# sort input file, excluding the first two header lines
NR<3 { print $0; next } { print $0 | "sort -k1" }
