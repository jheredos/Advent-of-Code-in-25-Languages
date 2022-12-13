import std/strutils
import std/sets

type pair = tuple[x: int, y: int]

func getX(s: string): int = 
  case s
  of "U": 0
  of "R": 1
  of "D": 0
  of "L": -1
  else: 0

func getY(s: string): int =
  case s
  of "U": 1
  of "R": 0
  of "D": -1
  of "L": 0
  else: 0

proc readLine(line: string): seq[pair] =
  let 
    step = line.split ' '
    direction = step[0]
    distance = parseInt step[1]
    x = getX direction
    y = getY direction

  for i in 0..distance-1: result.add (x,y)

proc readInput(): seq[pair] =
  let file = readFile "input.txt"
  let lines = splitLines file
  for line in lines: result &= readLine line

func one(x: int): int =
  if x == 0:  0
  elif x > 0: 1
  else:      -1

func abs(x: int): int =
  if x < 0: -x
  else: x

func follow(h: pair, t: pair): pair =
  let
    dx = h.x - t.x
    dy = h.y - t.y
  if abs(dx) <= 1 and abs(dy) <= 1: 
    (t.x, t.y)                       # in contact
  elif abs(dx) > 0 and abs(dy) > 0: 
    (t.x + one(dx), t.y + one(dy))   # move diagonally
  elif abs(dx) <= 1: 
    (t.x, t.y + one(dy))             # move up/down
  else: 
    (t.x + one(dx), t.y)             # move right/left 

proc solve1(steps: seq[pair]): int =
  var
    h: pair = (0, 0)
    t: pair = (0, 0)
    visited = toHashSet([t])

  for step in steps:
    h.x += step.x
    h.y += step.y
    t = follow(h,t)
    visited.incl t

  visited.len

proc solve2(steps: seq[pair]): int =
  var 
    rope: seq[pair] = @[]
    visited = toHashSet([(0,0)])
  for i in 0..9: rope &= (0,0)

  for step in steps:
    rope[0].x += step.x
    rope[0].y += step.y
    for i in 1..rope.len-1:
      rope[i] = follow(rope[i-1], rope[i])
    visited.incl rope[rope.len-1]
  
  visited.len



let 
  steps = readInput()
  solution1 = solve1(steps)
  solution2 = solve2(steps)

echo solution1
echo solution2
