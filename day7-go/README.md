# Day 7 - Go
Today's problem required a lot of work just to parse the input, so I went with something familiar. For creating a data structure like the file tree here, Go's structs and rigid typing allow you to feel pretty confident about what you're writing. Go can certainly feel a bit clunky. Iterating over something? You have to use `for`. Something returns a value and an error? You'd better handle it with a `if err != nil {...}`. But the nice part about that is 1) it forces consistency, and as a consequence it's usually pretty easy to read, and 2) it speeds up the programming process, since you spend less time thinking about *how* to write something and more on *what* you're writing. Once you have the algorithm clear in your mind, it practically writes itself.

That said, while writing Go is easy and productive, as a language it doesn't really feel as fun as some others. 

**Rating**: 7/10