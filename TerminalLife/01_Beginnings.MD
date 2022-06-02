# 01_Permissions

The BASH shell is the most commonly used shell in Linux. There are a lot of other ones (namely Z-Shell and fish), but these tend to be for dirty hipsters (I am a big <>< fan but it's pretty weird so i don't recommend it for a tutorial!)

You will start in your home directory - this is indicated by a `~` symbol:

`jakegt1@soulcatcher:~$`

This is acutally just a normal path though. It's the equivalent of `C:\Users\%USER%` in windows, but you can quickly refer to it as `~`.

Like in windows, there are many commands you can execute while in a shell. Firstly, we'll use `pwd`. Try it out, you should get a result like so:

```bash
jakegt1@soulcatcher:~$ pwd
/home/jakegt1
```

That's the real path of our home directory, and this is typical among any linux distro. It is very uncommon to have anything else, it will almost always be `/home/$USER`.

So, let's go through some of the typical, every day linux commands you might want to use:

## ls

`ls` - Lists files in the current working directory (you can find your current working directory via `pwd`!)

If you `ls` now, you'll find that you have no files in your home directory:

```
jakegt1@soulcatcher:~$ ls
jakegt1@soulcatcher:~$
```

But, is it acutally empty.. In linux, there is a concept of `hidden files` - these are all prefixed by `.`, and can be viewed by adding `-a` to your ls command:

```
jakegt1@soulcatcher:~$ ls -a
.  ..  .bash_logout  .bashrc  .landscape  .motd_shown  .profile
jakegt1@soulcatcher:~$
```

There are also two special files, `.` and `..`. `.` indicates the current directory itself, and `..` indicates the directory above the current one. So, in our current state, `.` will be `/home/jakegt1`, and `..` will be `/home`.

If you want to check if a file exists, you can use a wildcard:

```
jakegt1@soulcatcher:~$ ls -a .bash*
.bash_logout  .bashrc
```

A `*` is what is called a `glob`. In this case, this will collect all files that start with `.bash`.

Another helpful feature of ls is `-l`:

```
jakegt1@soulcatcher:~$ ls -al
total 24
drwxr-xr-x 3 jakegt1 jakegt1 4096 Jun  2 16:44 .
drwxr-xr-x 3 root    root    4096 Jun  2 16:43 ..
-rw-r--r-- 1 jakegt1 jakegt1  220 Jun  2 16:43 .bash_logout
-rw-r--r-- 1 jakegt1 jakegt1 3771 Jun  2 16:43 .bashrc
drwxr-xr-x 2 jakegt1 jakegt1 4096 Jun  2 16:44 .landscape
-rw-r--r-- 1 jakegt1 jakegt1    0 Jun  2 16:44 .motd_shown
-rw-r--r-- 1 jakegt1 jakegt1  807 Jun  2 16:43 .profile
```

This shows you:

* The permissions of the file (`drwxr-x-rx`)
* Who owns the file (`jakegt1`)
* Which group owns the file (`jakegt1`)
* The size of the file (`4096`)
* When it was created (... the date)
* And of course, the name of the file.

There are a lot of other options for the `ls` command, which you can see yourself with `ls --help`. Massive wall of text though. Be prepared.

(We'll get into permissions later)

## Other commands

Some simpler commands to understand are here:

`echo` - Prints strings to your terminal

```
jakegt1@soulcatcher:~$ echo "Hello World"
Hello World
```

`cd` - Changes directory
```
jakegt1@soulcatcher:~$ cd ..
jakegt1@soulcatcher:/home$ pwd
/home
jakegt1@soulcatcher:/home$ cd ~
jakegt1@soulcatcher:~$ pwd
/home/jakegt1
```

## Environment Variables

In BASH, you have two types of variables (this is probably simplifying stuff, but it makes sense to view it this way

The most important ones are `Environment Variables`. You will already have many of them set, and they were hinted at earlier. Try `echo /home/$USER`, and you will see how they work.

The default list of environment variables can be listed via the `env` command. Be warned, this is a large wall of text, but some of these are **very** important:

### PATH
This is the list of paths that you can find executables. For example, PATH usually includes the following paths by default:

* /usr/bin
* /bin

These will have many executables in, including all the ones you have already been using:

```
jakegt1@soulcatcher:~$ ls -l /usr/bin/ls
-rwxr-xr-x 1 root root 142144 Sep  5  2019 /usr/bin/ls
```

If `/usr/bin` was not listed under your PATH, you would not be able to use `ls` without using it's full PATH. So a good rule of thumb - make sure you don't delete or unset your PATH!

The other very important one is `HOME`. A lot of programs tend to shove stuff in there under hidden directories. it is also where your own personal user config will be loaded, so you tend to not want to change this one!

You can set environment variables yourself via the `export` command:

```bash
jakegt1@soulcatcher:~$ export MYVAR=var
jakegt1@soulcatcher:~$ echo "$MYVAR" # Wrapping variables in quotes is a very good idea, as will be explained later!
var
jakegt1@soulcatcher:~$
```

Environment variables tend to be used a lot, and they also exist in windows. One you will see a lot is `JAVA_HOME`, which sets where your default Java distro is. It's also well, a pain in the ass.

