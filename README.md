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

```
Usage:
./scorer
./scorer [flags]

flags
    -d, --daemon                     tell the process to run as a daemon
    -k, --kill                       kill the daemon process if its running
    -h, --help                       help
```

## To do

* Show all the matches at present
* Show scores of matches based on team name or key
* Write test for the program
* Make the program installable as a ruby gem