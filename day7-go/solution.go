package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	bytes, err := ioutil.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}

	input := strings.Split(string(bytes), "\n")
	root, err := BuildTree(input[1:])
	if err != nil {
		panic(err)
	}

	// part 1
	total := root.Search()
	fmt.Println(total)

	// part 2
	best := root.Search2()
	fmt.Println(best)
}

type Node struct {
	Name     string
	Files    int64
	Parent   *Node
	Children map[string]*Node
}

func BuildTree(input []string) (*Node, error) {
	root := &Node{
		Name:     "/",
		Parent:   nil,
		Children: make(map[string]*Node),
	}

	dir := root
	for len(input) > 0 {
		parts := strings.Split(input[0], " ")
		if parts[0] != "$" {
			return root, fmt.Errorf("Line \"%s\" is not a command", input[0])
		}

		var err error
		if parts[1] == "ls" {
			input, err = dir.Ls(input[1:])
			if err != nil {
				return root, err
			}
		} else if parts[1] == "cd" {
			switch parts[2] {
			case "/":
				dir = root
			case "..":
				dir = dir.Parent
			default:
				dir, _ = dir.Children[parts[2]]
			}
			input = input[1:]
		}
	}

	return root, nil
}

func (n *Node) Ls(input []string) ([]string, error) {
	for i, line := range input {
		parts := strings.Split(line, " ")
		switch parts[0] {
		case "$":
			return input[i:], nil
		case "dir":
			dirName := parts[1]
			n.Children[dirName] = &Node{
				Name:     dirName,
				Parent:   n,
				Children: make(map[string]*Node),
			}
		default:
			size, err := strconv.ParseInt(parts[0], 10, 0)
			if err != nil {
				return input, err
			}
			n.Files += size
		}
	}

	return []string{}, nil
}

func (n *Node) Size() int64 {
	sum := n.Files

	if n.Children == nil {
		return sum
	}

	for _, dir := range n.Children {
		sum += dir.Size()
	}

	return sum
}

// part 1
func (root *Node) Search() int64 {
	var total int64
	q, next := []*Node{root}, []*Node{}

	for len(q) > 0 {
		for _, n := range q {
			if n.Size() < 100000 {
				total += n.Size()
			}

			for _, m := range n.Children {
				next = append(next, m)
			}
		}
		q, next = next, []*Node{}
	}

	return total
}

// part 2
func (root *Node) Search2() int64 {
	needed := 30000000 - (70000000 - root.Size())
	best := root.Size()
	q, next := []*Node{root}, []*Node{}

	for len(q) > 0 {
		for _, n := range q {
			size := n.Size()
			if size < needed {
				continue
			}

			if size < best {
				best = size
			}

			for _, m := range n.Children {
				next = append(next, m)
			}
		}
		q, next = next, []*Node{}
	}

	return best
}
