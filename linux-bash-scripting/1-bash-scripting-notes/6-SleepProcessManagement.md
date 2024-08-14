# Linux Bash Scripting -Part 6 

## Sleep and Process Management

### How to pause a script?
we can pause a script with this command
```bash
$ sleep 5
```
- sleep is a command that pauses the script for the specified number of seconds.
- 5 is the number of seconds that the script will be paused for.

Let's create a new script called delay.sh
```bash
$ touch delay.sh
$ chmod 755 delay.sh
$ subl delay.sh
```
then we write this in the script
```
#!/usr/bin/env bash

DELAY=$1

if [ -z $DELAY ]
then
	echo "You must provide a delay"
	exit 1
fi

echo "Going to sleep for $DELAY seconds"
sleep $DELAY
echo "We are awake now!"

exit 0
```

then we run the script
```bash
$ ./delay.sh 5
```
and we get this output
```
Going to sleep for 5 seconds
We are awake now!
```
### How to run a script in the background?
we can run a script in the background with this command
```bash
$ ./delay.sh 5 &
```
- & is a command that runs the script in the background.
- 5 is the number of seconds that the script will be paused for.
- we can run multiple scripts in the background like this
```bash
$ ./delay.sh 5 & ./delay.sh 10 & ./delay.sh 15 &
```
- we can run multiple scripts in the background and wait for them to finish like this
```bash
$ ./delay.sh 5 & ./delay.sh 10 & ./delay.sh 15 & wait
```
- wait is a command that waits for all the background processes to finish.
 This our output
```
[1] 110605
[2] 110606
[3] 110607
Going to sleep for 5 seconds
Going to sleep for 15 seconds
Going to sleep for 10 seconds
We are awake now!
[1]   Done                    ./delay.sh 5
We are awake now!
[2]-  Done                    ./delay.sh 10
We are awake now!
[3]+  Done                    ./delay.sh 15
```
- [1] 110605 is the process id of the first background process.
- [2] 110606 is the process id of the second background process.
- [3] 110607 is the process id of the third background process.

### How to kill a process?
we can kill a process with this command
```bash
$ kill 110605
```
- kill is a command that kills a process.

### How to kill all background processes?
we can kill all background processes with this command
```bash
$ kill $(jobs -p)
```
- jobs is a command that lists all the background processes.
- -p is an option that prints the process ids of the background processes.
- $(jobs -p) is a command substitution that executes the jobs -p command and returns the output as a string.
- kill $(jobs -p) is a command that kills all the background processes.
- use with caution. This command will kill all the background processes.

### Watching processes

#### How to watch processes?
we can watch processes with this command
```bash
$ watch -n 1 ps
```
- watch is a command that runs a command repeatedly and displays the output.
- -n 1 is an option that runs the command every 1 second.
- ps is a command that lists all the processes.

Let's create a new script called proc.sh
```bash
$ touch proc.sh
$ chmod 755 proc.sh
$ subl proc.sh
```
then we write this in the script
```
#!/usr/bin/env bash

STATUS=0

if [ -z $1 ]
then
    echo "You must provide a PID"
    exit 1
fi
echo "Watching PID $1"
while [ $STATUS -eq 0 ]
do
    ps $1 > /dev/null
    STATUS=$?
    sleep 1
done

echo "Process $1 has terminated"

exit 0
```
- > ps $1 is a command that lists the process with the specified process id.
- > /dev/null is a redirection operator that redirects the output of the command to /dev/null.
  > /dev/null is a special file that discards all the output.
  > /dev/null is a black hole for data.
  > then STATUS=$? is a command that sets the STATUS variable to the exit code of the previous command.
  > sleep 1 is a command that pauses the script for 1 second.
  > why sleep 1? because we don't want to overload the CPU.

#### Excercise

Use proc,sh to watch delay.sh

##### Solution

```bash
/home/parham/linuxLearning took 8s 
$ ./delay.sh 15 &
[1] 113138
Going to sleep for 15 seconds

/home/parham/linuxLearning 
✦ $ ./proc.sh 113138
Watching PID 113138
We are awake now!
Process 113138 has terminated
[1]+  Done                    ./delay.sh 15
```