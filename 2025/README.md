# Advent of Code 2025

## Daily Workflow

```bash
# 1. Generate files (if not current day, set day first: mix aoc.set -d X)
mix aoc.create

# 2. Copy example from AoC website into test file, replace CHANGE_ME with expected answer

# 3. Write solution in lib/aoc2025/y25/day0X.ex

# 4. Test with example
mix aoc.test

# 5. Run with real input
mix aoc.run

# 6. Copy answer and paste into adventofcode.com
```

## Files

- Solution: `lib/aoc2025/y25/day0X.ex`
- Test: `test/2025/day0X_test.exs`
- Input: `priv/input/2025/day-0X.inp` (auto-downloaded)

## Setup (already done)

- Session cookie in `~/.adventofcode.session`
- Config in `config/config.exs`
