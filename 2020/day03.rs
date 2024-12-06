use std::fs;
use std::io::{self, prelude::*};
use std::time::Instant;

fn read_input(file_path: &str) -> Vec<Vec<char>> {
    let file = fs::File::open(file_path).expect("Unable to open the file");
    let reader = io::BufReader::new(file);
    let mut lines = vec![];
    for line in reader.lines() {
        lines.push(line.unwrap().chars().collect());
    }
    lines
}

fn part1(input: &Vec<Vec<char>>, slope1: usize, slope2: usize) -> u32 {
    let mut x = 0;
    let mut y = 0;
    let mut trees_count = 0u32;
    while y < input.len() {
        if input[y][x] == '#' {
            trees_count += 1;
        }
        x = (x + slope1) % input[0].len();
        y += slope2;
    }
    trees_count
}

fn part2(input: &Vec<Vec<char>>) -> u32 {
    let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)];
    let mut result = 1u32;
    for &(slope1, slope2) in &slopes {
        result *= part1(input, slope1, slope2);
    }
    result
}

fn main() {
    let input = read_input("data/input03.txt");
    
    let start_time = Instant::now();
    let part1_result = part1(&input, 3, 1);
    let duration = start_time.elapsed();
    println!("Part 1: {} (Time elapsed: {:?})", part1_result, duration);
    
    let start_time = Instant::now();
    let part2_result = part2(&input);
    let duration = start_time.elapsed();
    println!("Part 2: {} (Time elapsed: {:?})", part2_result, duration);
}
