# 03_Scripting

So, let's get our environment ready for scripting.

if you're not already, use `cd` to get to your HOME directory. You can use either:

```bash
cd ~
cd "$HOME"
```

Now, we'll make a directory for our work. Let's call it `projects`:

```bash
jakegt1@soulcatcher:~$ mkdir projects
jakegt1@soulcatcher:~$ cd ./projects/ # ./ - current directory
jakegt1@soulcatcher:~/projects$
```

There are some files in this git repo which will be used for the tasks in this readme. So, best to clone this git repo. For now, we can just use https cloning as it's simpler, but for an extension task you can try set up an ssh key - it's much faster to clone that way. [See here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

Try it yourself, it should be the same as cloning on windows.

<details>
  <summary>If you're not sure, click here</summary>
  ```
  git clone https://github.com/jakegt1/HowToLinux.git
  git clone git@github.com:jakegt1/HowToLinux.git
  ```
</details>

At this point, it would be better to get onto VSCode. Make sure you have installed the `Remote Development` extension.

![Vscode remote](./VScode.png)

After that, you should have a terminal pop up. `cd` to the cloned repository and then type `code -r .` to open this project in VSCode.

The test harness and scripts are in [../03_Scripting/](../03_Scripting). First, we should run test.sh to see where we're at.

```bash
jtorranc@soulcatcher:~/projects/LinuxHowTo$ cd 03_Scripting
jtorranc@soulcatcher:~/projects/linuxHowTo/03_Scripting$ ./test.sh
 ✗ Concat two strings can concat two strings
   (in test file test.sh, line 4)
     `result="$(./concat_two_strings.sh foo bar)"' failed with status 126
   /tmp/bats.3059.src: line 4: ./concat_two_strings.sh: Permission denied
 ✗ Add can add two
   (in test file test.sh, line 9)
     `result="$(./add.sh 2 6)"' failed with status 126
   /tmp/bats.3067.src: line 9: ./add.sh: Permission deniede
```

Ahh, permissions again. We'll use `chmod` to fix that.

`chmod` can work in multiple ways:

```bash
chmod u+x ./add.sh ./concat_two_strings.sh # Add the execution permission to the user (the owner)
chmod a+x ./add.sh # Add the execution permission to everyone
chmod 755 ./add.sh # Short form - 755: `rwxr-xr-x`
chmod 644 ./add.sh # Short form - 644: `rw-r--r--`. This is what it starts with.
```

I find the short form much easier to understand, to be honest. You will almost always use 755 and 644, and ocasionally 600 or 400 when you want something that cannot be read by others (like an ssh key!)

OK, let's try again..

```bash
jakegt1@soulcatcher:~/projects/HowToLinux/03_Scripting$ chmod 755 add.sh concat_two_strings.sh
jakegt1@soulcatcher:~/projects/HowToLinux/03_Scripting$ ./test.sh
 ✗ Concat two strings can concat two strings
   (in test file test.sh, line 5)
     `[ "$result" = "foobar" ]' failed
 ✗ Add can add two
   (in test file test.sh, line 10)
     `[ "$result" -eq 8 ]' failed

2 tests, 2 failures
```

# concat_two_strings.sh

Let's view [concat_two_strings.sh](../03_Scripting/concat_two_strings.sh).

```bash
#!/bin/bash

RESULT=

echo -n "$RESULT"
```

Right now, it doesn't really do anything, but it does at the least show how to set variables, and how to report them. Most bash scripts typically do this, they just output their result as a string to the shell.

Arguments to a script themselves are special variables. These can be accessed by the number of the argument:

```
$0 - Name/path to script
$1 - First argument
$2 - Second argument
$3 ...
```

Considering this, hopefully the `RESULT` variable in concat_two_strings.sh should be pretty self explanatory. As a note, you can put variables one after the other: `echo "$MYVAR$OTHERVAR"` is perfectly acceptable.

You can test your code by executing it:

```
jakegt1@soulcatcher:~/projects/HowToLinux/03_Scripting/solutions$ ./concat_two_strings.sh foo bar
foobarjakegt1@soulcatcher:~/projects/HowToLinux/03_Scripting/solutions$
jakegt1@soulcatcher:~/projects/HowToLinux/03_Scripting/solutions$ ./concat_two_strings.sh fu ck
fuckjakegt1@soulcatcher:~/projects/HowToLinux/03_Scripting/solutions$
```

It may look slightly odd that the result comes straight before your terminal line, but that's because of how echo has been used - `echo -n` removes the new line character at the end of the output.

After this, `./test.sh` should report one pass.

# add.sh

So, now we need to add. Doing maths in bash can be done by using `$(())`. So, for example:

```bash
MYVAR=1
SOME_MATHS=$(($MYVAR + $MYVAR))
echo -n "$SOME_MATHS"
# 2
```

So, overall should be similar to `concat_two_strings.sh` - just with a little bit extra. You can use variables in `$(())` too, of course.

