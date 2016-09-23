package main

import (
	"fmt"
	"flag"
)

var command string
var floatForRound float64

//var command = flag.String("command", "round", "Комманда(round...)")
//var floatForRound = flag.Float64("floatForRound",1.5, "Округлить до целого")
//var ip = flag.Int("flagname", 1234, "help message for flagname")

func init() {
	flag.StringVar(&command, "c", command, "Комманда(round...)")
	flag.Float64Var (&floatForRound, "round", floatForRound, "Округлить до целого")
}

func round(f float64) int {
	if f < -0.5 {
		return int(f - 0.5)
	}
	if f > 0.5 {
		return int(f + 0.5)
	}
	return 0
}

func main() {
	flag.Parse()
	switch {
	default:
		fmt.Printf("%s", "Не указана или неверная комманда введите -h для получения помощи")
	case command == "round":
		fmt.Printf("%d", round(floatForRound))
	}
}
