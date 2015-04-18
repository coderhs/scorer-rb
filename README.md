# scorer.rb

Ruby implementation of scorer (https://github.com/alfie-max/scorer) to fetch live scores and send notification

## How to run the program

```sh
$ git clone https://github.com/coderhs/scorer-rb.git
$ cd scorrer-rb
$ bundle
$ ./scorer
```

## Usage

### Basic

```
Usage:
./scorer
./scorer [flags]

flags
    -d, --daemon                     tell the process to run as a daemon
    -k, --kill                       kill the daemon process if its running
    -h, --help                       help
```

### Display all the matches for which score is available

Command

```sh
./scorer -l
```

Result
``[Game Index]. [Match]``

```sh
0. Australia Under-19s 242/7 * v England Under-19s 241/7 
1. Sunrisers Hyderabad 163/8 * v Delhi Daredevils 167/4 
2. Kings XI Punjab 123/5 * v Kolkata Knight Riders

```

### Show score of particular game

Get the game index using command `./scorer -l`.

Command

```sh
./scorer 0
```

## To do

* Write test for the program
* Make the program installable as a ruby gem