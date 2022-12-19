import Foundation

func readInput(path: String) -> String {
  var data = ""
  do {
    data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
  } catch {
    print("error occured: \(error)")
  }
  return data
}

func readSteps(steps: [String]) -> [Int] {
  var values: [Int] = [1]
  for step in steps {
    let prev = values.last ?? 1
    values.append(prev)

    if step != "noop" {
      let parts = step.split(separator: " ")
      var amount = 0
      for part in parts {amount += Int(part) ?? 0}
      values.append(prev + amount)
    }
  }
  return values
}

func solve1(steps: [String]) -> Int {
  let values = readSteps(steps: steps)
  var sum = 0
  for i in [20, 60, 100, 140, 180, 220] {
    sum += values[i-1] * i
  }
  return sum
}


func solve2(steps: [String]) -> [String] {
  let values = readSteps(steps: steps)
  var pixels = Array(repeating: ".", count: values.count)
  for i in 0..<values.count {
    if values[i] < (i%40)-1 { continue }
    if values[i] > (i%40)+1 { continue }
    pixels[i] = "#"
  }
  return pixels
}

let input = readInput(path: "./input.txt")
let steps = input.split(separator: "\n").map { String($0) }

let solution1 = solve1(steps: steps)
print(solution1)

let solution2 = solve2(steps: steps)
for i in 0..<solution2.count {
  if i % 40 == 39 {
    print(solution2[i])
  } else {
    print(solution2[i], terminator: "")
  }
}