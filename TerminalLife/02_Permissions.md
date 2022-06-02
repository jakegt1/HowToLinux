# 02_Permissions

So, before we start writing scripts, it would be best to understand permissions in Linux, to a simple degree. 

Let's take the usage of `ls` from the first example, and then look at two of these files.

```bash
jakegt1@soulcatcher:~$ ls -al .
total 24
drwxr-xr-x 3 jakegt1 jakegt1 4096 Jun  2 16:44 .
drwxr-xr-x 3 root    root    4096 Jun  2 16:43 ..
-rw-r--r-- 1 jakegt1 jakegt1  220 Jun  2 16:43 .bash_logout
-rw-r--r-- 1 jakegt1 jakegt1 3771 Jun  2 16:43 .bashrc
drwxr-xr-x 2 jakegt1 jakegt1 4096 Jun  2 16:44 .landscape
-rw-r--r-- 1 jakegt1 jakegt1    0 Jun  2 16:44 .motd_shown
-rw-r--r-- 1 jakegt1 jakegt1  807 Jun  2 16:43 .profile
```

The first file, `.bashrc`. This is a config file for the BASH shell, and can be used to set environment variables when you login (using `export`!).

```
-rw-r--r-- 1 jakegt1 jakegt1 3771 Jun  2 16:43 .bashrc
```

The important part of the line is `-rw-r--r--`. This means that:

* The file can be read and written to by the owner (`jakegt1`)
* The file can be read by members of the group (`jakegt1`)
* Everyone else can read it too.

At the moment, nobody can `execute` this file. This makes sense anyway, as `.bashrc` isn't a file you intend to execute.

Now, lets see another file: `ls`. or, it's acutal path of course, `/usr/bin/ls`.

```
jakegt1@soulcatcher:~$ ls -l /usr/bin/ls
-rwxr-xr-x 1 root root 142144 Sep  5  2019 /usr/bin/ls
```

For this file:

* The file can be read, written, and excuted by the owner (`root`)
* The file can be read and executed by the group (`root`)
* THe file can be read and executed by everyone else

`root` is a special user, with ID 0. This is the super user of the system, who can see and read everything. You should only ever be using this account when you need to - typically only when system config needs to be changed or programs need to be installed. As a rule of thumb, `never` create files with root in user's directories - they won't be able to remove them!

This is very typical of programs installed on a linux machine. This simply makes it so as a user, you can execute `ls` but not edit it. This is usually because well, if i could write to `ls`, I could remove it then practically break the whole system. Kind of hard to navigate what you're doing if you can't even see files in a folder!

Permissions can be changed using the `chmod` executable. This is very important, as any file you create will be by default, permission of `-rw-r--r--` with yourself as the owner. Not even you will be able to execute it!

Directories are slightly different, and tend to default to `drwxr-xr-x`. This means that:

* The directory can be seen, moved, and traversed by the owner
* The directory can be seen and traversed by the group
* The directory can be seen and traversed by everyone else.

This is very typical of system folders that need to be seen by everyone, like `/usr/bin`. For system folders that are security heavy though, you will more likely see `drwx------` - only allowing the user that owns it to see it (and the super user, `root`.)

So before we go onto the next page, we're going to do some admin to set up our dev environment. To do this, we're going to use what's called a package manager - this installs executables onto our system. In Ubuntu specifically, this is called `apt`. There are other ones, including `dnf`, `yum`, `pkg` in other distros, but they are all quite similar and you should be fine with apt.

So, let's use apt then. When starting a new system, you should always run update first - this pulls in the latest definitions of packages so you have the latest security updates etc.

```
jakegt1@soulcatcher:~$ apt update
Reading package lists... Done
E: Could not open lock file /var/lib/apt/lists/lock - open (13: Permission denied)
E: Unable to lock directory /var/lib/apt/lists/
```

Ahh. But we aren't the super user - so we'll need to be root to do this. We can run one off commands as the super user via the `sudo` executable (aka, `Super User Do`)

```
jakegt1@soulcatcher:~$ sudo apt update
[sudo] password for jakegt1:
Get:1 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Hit:2 http://archive.ubuntu.com/ubuntu focal InRelease
...
```

Fill in your password and let it update. There will be a message about upgrading at the bottom - don't worry about that for now.

We will want to install the following packages:

* zip
* unzip
* git
* python3
* bats
* shellcheck

To do this, we'll use the `install` command as part of `apt`:

```
sudo apt install zip unzip git python3 shellcheck
Reading package lists... Done
Building dependency tree
...
```

After this, you should be ready to go to the next step.
