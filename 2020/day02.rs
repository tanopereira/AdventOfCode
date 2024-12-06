use std::fs;
use std::io::{self, BufRead};
use std::time::Instant;

fn read_lines(file_path: &str) -> io::Result<Vec<String>> {
    let file = fs::File::open(file_path)?;
    let reader = io::BufReader::new(file);
    reader.lines().collect()
}

fn part1(input: &[String]) -> i32 {
    let start = Instant::now();
    let mut count = 0;
    for line in input {
        let parts: Vec<&str> = line.split(' ').collect();
        let limits: Vec<i32> = parts[0]
            .split('-')
            .map(|s| s.parse().expect("Failed to parse integer"))
            .collect();
        let letter = parts[1].chars().next().expect("Invalid character");
        let pwd = parts[2];
        let matches: Vec<char> = pwd.chars().filter(|&c| c == letter).collect();
        if limits[0] <= matches.len() as i32 && matches.len() as i32 <= limits[1] {
            count += 1;
        }
    }
    let duration = start.elapsed();
    println!("Part 1 took {:?}", duration);
    count
}

fn part2(input: &[String]) -> i32 {
    let start = Instant::now();
    let mut count = 0;
    for line in input {
        let parts: Vec<&str> = line.split(' ').collect();
        let positions: Vec<usize> = parts[0]
            .split('-')
            .map(|s| s.parse().expect("Failed to parse integer"))
            .map(|n: i32| n as usize - 1) // Convert to zero-based index with explicit type annotation
            .collect();
        let letter = parts[1].chars().next().expect("Invalid character");
        let pwd = parts[2];
        let chars: Vec<char> = pwd.chars().collect();
        let count_matches = [chars[positions[0]], chars[positions[1]]]
            .iter()
            .filter(|&&c| c == letter)
            .count();
        if count_matches == 1 {
            count += 1;
        }
    }
    let duration = start.elapsed();
    println!("Part 2 took {:?}", duration);
    count
}

fn main() -> io::Result<()> {
    let input = read_lines("data/input02.txt")?;
    part1(&input);
    part2(&input);
    Ok(())
}