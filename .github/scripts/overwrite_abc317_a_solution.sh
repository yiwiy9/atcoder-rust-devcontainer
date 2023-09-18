#!/bin/bash

# Function to Overwrite ABC317 Problem A Solution in Rust
filepath="$1"
cat > "$filepath" <<EOF
use proconio::input;
use superslice::*;
fn main() {
    input! { n: usize,h: usize,x: usize,p: [usize; n] };
    println!("{}", p.lower_bound(&(x - h)) + 1);
}
EOF
