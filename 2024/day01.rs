use std::collections::HashMap;
use std::fs;
use std::time::Instant;

fn parse_input(input: &str) -> (Vec<i32>, Vec<i32>) {
    let mut left = Vec::new();
    let mut right = Vec::new();

    for line in input.lines() {
        let parts: Vec<&str> = line.split_whitespace().collect();
        if parts.len() == 2 {
            if let (Ok(l), Ok(r)) = (parts[0].parse::<i32>(), parts[1].parse::<i32>()) {
                left.push(l);
                right.push(r);
            }
        }
    }

    (left, right)
}

fn part1(mut left: Vec<i32>, mut right: Vec<i32>) -> i32 {
    left.sort();
    right.sort();
    left.iter().zip(right.iter()).map(|(x, y)| (x - y).abs()).sum()
}

fn part2(left: Vec<i32>, right: Vec<i32>) -> i32 {
    let mut counts = HashMap::new();

    for &elem in &right {
        *counts.entry(elem).or_insert(0) += 1;
    }

    left.iter().map(|&elem| elem * *counts.get(&elem).unwrap_or(&0)).sum()
}

fn main() {
    let start_reading = Instant::now();
    let input = fs::read_to_string("data/input01.txt").expect("Failed to read file");
    let reading_duration = start_reading.elapsed();

    let (left, right) = parse_input(&input);

    let start_part1 = Instant::now();
    let part1_result = part1(left.clone(), right.clone());
    let part1_duration = start_part1.elapsed();

    let start_part2 = Instant::now();
    let part2_result = part2(left, right);
    let part2_duration = start_part2.elapsed();

    println!("Reading input took: {:?}", reading_duration);
    println!("Part 1: {} (took: {:?})", part1_result, part1_duration);
    println!("Part 2: {} (took: {:?})", part2_result, part2_duration);
}