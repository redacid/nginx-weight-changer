package main

import (
	"fmt"
	"flag"
	"regexp"
	"os"
	"bufio"

)

var command string
var strForGrep string
var fileForGrep string
var floatForRound float64

//var command = flag.String("command", "round", "Комманда(round...)")
//var floatForRound = flag.Float64("floatForRound",1.5, "Округлить до целого")
//var ip = flag.Int("flagname", 1234, "help message for flagname")

func init() {
	flag.StringVar(&command, "c", command, "Комманда(round,grep ...)")
	flag.Float64Var (&floatForRound, "round", floatForRound, "Число для округления до целого")
	flag.StringVar (&strForGrep, "grep", strForGrep, "Строка(regex) для grep фильтра")
	flag.StringVar (&fileForGrep, "grepfile", strForGrep, "Файл для grep фильтра")
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

func grep(re, filename string) {
	regex, err := regexp.Compile(re)
	if err != nil {
		return // there was a problem with the regular expression.
	}

	fh, err := os.Open(filename)
	f := bufio.NewReader(fh)

	if err != nil {
		return // there was a problem opening the file.
	}
	defer fh.Close()

	buf := make([]byte, 1024)
	for {
		buf, _ , err = f.ReadLine()
		if err != nil {
			return
		}

		s := string(buf)
		if regex.MatchString(s) {
			fmt.Printf("%s\n", string(buf))
		}
	}
}

func replace(re, repl, filename string) {
	regex, err := regexp.Compile(re)
	if err != nil {
		return // there was a problem with the regular expression.
	}

	fh, err := os.Open(filename)
	f := bufio.NewReader(fh)

	if err != nil {
		return // there was a problem opening the file.
	}
	defer fh.Close()

	buf := make([]byte, 1024)
	for {
		buf, _ , err = f.ReadLine()
		if err != nil {
			return
		}

		s := string(buf)
		result := regex.ReplaceAllString(s, repl)
		fmt.Print(result + "\n")
	}
}

//func main() {
//	flag.Parse()
//	if flag.NArg() == 3 {
//		repl(flag.Arg(0), flag.Arg(1), flag.Arg(2))
//	} else {
//		fmt.Printf("Wrong number of arguments.\n")
//	}
//}

func main() {
	flag.Parse()
	switch {
	default:
		fmt.Printf("%s", "Не указана или неверная комманда введите -h для получения помощи\n")
	case command == "round":
		fmt.Printf("%d", round(floatForRound))
	case command == "grep":
		//fmt.Printf("%d", round(floatForRound))
		grep(strForGrep, fileForGrep)
	}
}
