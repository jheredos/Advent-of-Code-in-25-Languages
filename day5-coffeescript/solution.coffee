fs = require 'fs'

data = fs.readFileSync('./input.txt').toString()

parseStack = (lines, col) -> 
  stack = []
  row = lines.length - 2
  until row < 0 or lines[row][col] is ' '
    stack.push lines[row][col]
    row -= 1
  stack

parseSetup = (s) -> 
  lines = s.split '\n'
  result = {}
  for i in [1..9]
    col = lines[lines.length-1]
      .split('')
      .findIndex (c) => c == i.toString()
    result[i] = parseStack lines, col
  result

move = (state, step) ->
  [num, src, dest] = step.match /\d+/g
  num = parseInt num
  stack = []
  while num
    # part 1
    # stack.push state[src].pop()

    # part 2
    stack.unshift state[src].pop()

    num -= 1
  state[dest].push n for n in stack
  state

solve = (input) ->
  [setup, steps] = input.split '\n\n'
  state = parseSetup setup
  for step in steps.split '\n'
    state = move state, step
  state
  
endState = solve data
solution = ''
for i in [1..9]
  stack = endState[i.toString()]
  solution += stack[stack.length-1]

console.log solution