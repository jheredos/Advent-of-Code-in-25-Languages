import scala.io.Source

val input = Source.fromFile("./input.txt").mkString

def splitInput(inp: String): Array[Array[String]] =
  inp.split("\n").map(_.split(" "))

// part 1
def scoreShape(shape: String): Int =
  shape match {
    case "A" | "X" => 1 // rock
    case "B" | "Y" => 2 // paper
    case "C" | "Z" => 3 // scissors
    case _ => 0
  }

def calcScore(pair: Array[String]): Int = 
  pair match {
    // draw
    case Array(a, b) if scoreShape(a) == scoreShape(b) => 
      scoreShape(b) + 3
    // win
    case Array("A", "Y") | Array("B", "Z") | Array("C", "X") 
      => scoreShape(pair(1)) + 6
    // lose
    case Array("A", "Z") | Array("B", "X") | Array("C", "Y") 
      => scoreShape(pair(1))
    case _ => 0
  }

def scoreAll(inp: String): Int = 
  splitInput(inp)
    .map(calcScore)
    .foldLeft(0)((sum, s) => sum + s)

// part 2
def win(shape: String): Int = 
  (shape match {
    case "A" => scoreShape("B")
    case "B" => scoreShape("C")
    case "C" => scoreShape("A")
    case _ => 0
  }) + 6

def draw(shape: String): Int = 
  (shape match {
    case "A" => scoreShape("A")
    case "B" => scoreShape("B")
    case "C" => scoreShape("C")
    case _ => 0
  }) + 3

def lose(shape: String): Int = 
  shape match {
    case "A" => scoreShape("C")
    case "B" => scoreShape("A")
    case "C" => scoreShape("B")
    case _ => 0
  }

def scorePair(pair: Array[String]): Int =
  pair match {
    case Array(a, "X") => lose(a)
    case Array(a, "Y") => draw(a)
    case Array(a, "Z") => win(a)
    case _ => 0
  }


def scoreAll2(inp: String): Int = 
  splitInput(inp)
    .map(scorePair)
    .foldLeft(0)((sum, s) => sum + s)

println(scoreAll2(input))