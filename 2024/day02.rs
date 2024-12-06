use std::fs;
use std::time::Instant;
use rayon::prelude::*;

fn is_safe(b: &Vec<i32>) -> bool {
    // Rule 1: All differences should have the same sign or be zero
    let rule1 = b.iter().all(|&x| x.signum() == b[0].signum());
    // Rule 2: Absolute values of differences should be between 1 and 3 inclusive
    let rule2 = b.iter().all(|&x| (1..=3).contains(&x.abs()));
    rule1 && rule2
}

fn part1(input: &Vec<String>) -> usize {
    input
        .iter()
        .map(|line| {
            line.split_whitespace()
                .map(|x| x.parse::<i32>().unwrap())
                .collect::<Vec<i32>>()
        })
        .map(|v| {
            let b = v.windows(2).map(|w| w[1] - w[0]).collect::<Vec<i32>>();
            is_safe(&b) as usize
        })
        .sum()
}

fn part2(input: &Vec<String>) -> usize {
    input
        .par_iter()
        .map(|line| {
            let a: Vec<i32> = line
                .split_whitespace()
                .map(|x| x.parse().unwrap())
                .collect();
            let b: Vec<i32> = a.windows(2).map(|w| w[1] - w[0]).collect();

            if is_safe(&b) {
                return 1;
            }

            for i in 0..a.len() {
                let mut a_modified = a.clone();
                a_modified.remove(i);
                let b_modified: Vec<i32> = a_modified.windows(2).map(|w| w[1] - w[0]).collect();
                if is_safe(&b_modified) {
                    return 1;
                }
            }
            0
        })
        .sum()
}

fn main() {
    // Read input lines from file
    let now = Instant::now();
    let input: Vec<String> = fs::read_to_string("data/input02.txt")
        .expect("Failed to read file")
        .lines()
        .map(String::from)
        .collect();
    let elapsed = now.elapsed();
    println!("Time to read file: {:.2?}", elapsed);

    // Measure and print the time taken to execute Part 1
    let now = Instant::now();
    println!("Part1: {}", part1(&input));
    let elapsed = now.elapsed();
    println!("Time to execute Part 1: {:.2?}", elapsed);

    // Measure and print the time taken to execute Part 2
    let now = Instant::now();
    println!("Part2: {}", part2(&input));
    let elapsed = now.elapsed();
    println!("Time to execute Part 2: {:.2?}", elapsed);
}