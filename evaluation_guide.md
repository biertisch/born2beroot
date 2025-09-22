# Born2beroot: Evaluation Guide

## Signature

**Virtual Disk Image (.vdi)**: File used by VirtualBox to store the virtual machine's entire hard drive contents, including the operating system, applications, files, and settings. It functions as a virtual hard drive.

**Disk's Signature**: 40-digit hexadecimal number extracted from `.vdi` using the Secure Hash Algorithm 1 (`sha1sum`) and stored in `signature.txt`

**Useful Commands**:
* `sha1sum [vm_name].vdi > signature.txt` - extract signature.
* `sha1sum -c path/to/signature.txt` - verify signature from the folder of `.vdi`.

---
## Virtual Machine (VM)
Also known as **guest machine**. Software-based emulation of a physical computer hosted on a physical device (**host machine**), with its own operating system and virtual hardware (CPU, RAM, storage device, network card, etc.).

**Hypervisor**: Software programme that creates and runs VMs. It controls the resources of the host machine, allocating the necessary resources to the VM and isolating it from the system hardware and other VMs.

**VirtualBox** is a free and open-source virtualization software that serves a hypervisor.

### Benefits of VMs
* More convenient and cheaper than physical computers: they inexpensive, require less physical space and less maintenance.
* Software testing and development in multiple OS using only one physical computer.
* Safety and isolation for testing unstable or malicious programmes (cybersecurity).
* Flexibility for learning and legacy support.
* Simulation of real network environments.

---
## Operating System
Core software that manages a computer's hardware and software resources and provides a platform for running applications. It functions as a middle layer between the user, the applications and the hardware.

**Debian**: Free and open-source Linux distribution, i.e. complete OS centred on Linux kernel with additional tools, programmes, package managers, etc. One of the oldest and most influential Linux distributions, known for its stability, reliability and vast software repository.

**Advantages compared to Rocky**:
* Beginner-friendly (recommended by 42): easier to install and customize, lightweight. Ideal for general users, learners, developers, and community-driven projects, whereas Rocky is more suited to enterprises.
* Completely free and open-source: 100% community project, with a vast and diverse user community, extensive documentation, and well-understood practices.
* Extremely stable.
* Secure by design: with frequent security patches and updates.
* Versatile: suitable for general-purpose use (for example, as a desktop, server, or embedded system).
* Vast software repository, including APT package manager, which is renowned for its simplicity, robustness, and ease of dependency management.

**Useful Commands**:
* `sudo systemctl get-default` - verify there is no graphical interface. Expected output: `multiuser.target`.
* `hostnamectl` or `cat /etc/os-release` - confirm OS.

---
## Package Management
Both **apt** and **aptitude** are **package management tools** used on Debian-based systems to install, upgrade, search for and remove software packages.

**Software Package**: Bundle of files or metadate that together provide a piece of software ready to be installed in a computer. It can include program files, libraries, configuration files, documentation, and metadata.

**Dependencies**: Other software packages or libraries that a programme needs in order to work properly. Without these, the programme may fail to run, crash, or behave incorrectly.

**apt (Advance Package Tool)**: Default CLI tool used on Debian-base Linux systems for managing software packages. It is simple and user-friendly, automatically resolving and installing dependencies need by the packages. It uses **dpkg** under the hood, but adds dependency resolution and works with remote repositories.

**dpkg (Debian Package)**: Low-level package manager for Debian-based systems. It operates only with individual files at a local level, without handling dependencies automatically.

**aptitude**: Non-default tool, which offers both CLI and TUI (text user interface – with interactive menus and layout). It offers a smarter and more flexible dependency resolution, suggesting multiple ways to resolve conflicts.

---
## AppArmor (Application Armor)
Linux security module that enforces mandatory access control (MAC) on programmes – it limits what programmes can do (for example, which files, networks, or capabilities they can access) with security profiles. It helps to contain damage if a programme is compromised or buggy.

**Mandatory Access Control (MAC)**: Security module in which the OS strictly controls access to resources. Users or programmes cannot override or change those rules, even if they are administrators or root.

**Useful Commands**:
* `systemctl status apparmor` - check status of AppArmor.
* `sudo aa-status` - show AppArmor status and loaded profiles.

---
## Users & Groups

**Users**: People or system services who can log in or run processes. Each user has a username, UID, home directory, shell, and password.

**Groups**:
Collections of users, used to manage permissions more easily. Each group has a group name, GID, and list of members.

**Useful Commands**:
* `getent passwd` - list all user accounts.
* `getent passwd <username>` - search for a specific user.
* `getent group` - list all groups.
* `getent group <groupname>` - search for a specific group.
* `groups <username>` or `id <username>` - list the groups to which a user belongs.
* `sudo adduser <username>` - add user.
* `sudo deluser <username>` - delete user.
* `sudo addgroup <groupname>` - add group.
* `sudo delgroup <groupname>` - delete group.
* `sudo adduser <username> <groupname>` or `sudo usermod -aG <groupname> <username>` - add user to group.
* `sudo nano /etc/group` - remove user from group.

---
## Password Policy

**libpam-pwquality**: PAM (Pluggable Authentication Module) that enforces strong password policies on Linux systems. It is called from the PAM config file `/etc/pam.d/common-password` and reads its rules from `/etc/security/pwquality.conf`.

**Advantages of a Strong Password Policy**:
* Reduces risk of credential theft.
* Protects sensitive systems and data.
* Ensures compliance with standards.
* Encourages good user habits.

**Disadvantages**:
* Causes frustration.
* Makes it easier to forget passwords.
* Promotes workarounds and bad habits like writing passwords downs, reusing passwords with minor changes, or using predictable patterns.
* Promotes a false sense of security.

**Useful Commands**:
* `sudo nano /etc/login.defs` - edit password settings.
* `chage -M 30 <username>` - change max days until password expiration.
* `chage -m 2 <username>` - change min days before modifying a password.
* `chage -W 7 <username>` - change number of days before password expiration for warning.
* `sudo chage -l <username>` - check user's password settings.
* `sudo nano /etc/security/pwquality.conf` - change password complexity rules.
* `passwd <username>` - change password.

---
## Hostname
Name of computer (or host) on a network.
* **static** – main, persistent (stored in `/etc/hostname` and `/etc/hosts`);
* **transient** – temporary (set by DHCP or manually with hostname);
* **pretty** – human-readable version, which can contain spaces.

**Useful Commands**:
* `hostname` or `hostnamectl` - check hostname.
* (`hostnamectl set-hostname <new_hostname>` or `sudo nano /etc/hostname`) AND `sudo nano /etc/hosts` - change hostname.

---
## Disk Partitioning

**Storage Device**: Also known as **disk** or **hard drive**.Hardware component in the computer where all data is permanently saved, even when the power is off.

Examples: **HDD** (Hard Disk Drive) and **SSD** (Solid State Drive).

**Disk partitioning**: Process of dividing a hard drive (HDD or SSD) into separate, independent sections called **partitions**. Each partition acts like a separate disk, with its own file system and structure. This is useful to organize or isolate data on the same hardware. Yet, unlike VMs, partitions do not emulate hardware or provide OS isolation.

**Master Boot Record (MBR) partitioning scheme**: Older method for organizing and managing partitions on a hard drive. This is the default in VirtualBox. Replaced by the modern system **GPT** (GUID Partition Table).

**Primary partition**: Standard, standalone partition. One of them can be marked as “active” to boot an OS. You can have up to 4 primary partitions on a single MBR-style disk.

**Extended partition**: Special type of primary partition that acts as a container for multiple logical partitions. Only one extended partition is allowed.

**Logical partitions**: Used to bypass the 4-partition limit of MBR. You can have many logical partitions (=>128). They are part of the extended partition and not directly bootable.

**Encrypted partition**: Section of a storage device where all data is automatically stored in encrypted form and decrypted if you provide the correct password/key. It is useful to protect sensitive data from unauthorized access.

**Logical Volume Manager (LVM)**: Flexible way to manage disk storage on Linux systems, allowing you to create, resize, and organize storage volumes (partitions) easily and dynamically. In particular, it can combine multiple physical disks or partitions into one large storage pool, create logical volumes, and resize volumes dynamically without repartitioning.

**Physical Volume**: Actual physical disk or partition added to LVM.

**Volume Group**: Pools of storage made by combining one or more physical volume.

**Logical Volume**: Virtual partition carved out by LVM. Unlike a partition, it is not created directly on a disk, is not restricted to one disk, and has no fixed size.

**Mount Point**: Directory in Linux file system where a storage device (partition, logical volume) is attached so you can access the data inside it.

**Swap Area**: Portion of disk storage that acts as virtual memory when the system’s RAM is full – basically, extra backup memory beyond the physical RAM.

**Useful Commands**:
* `lsblk` - list information about block devices (i.e. devices used to store data in blocks).

---
## SUDO

**superuser (SU)**: Special user account on Unix/Linux systems, usually called **root**, that has **full administrative privileges**, like install or remove software, modify system files, change permissions, manage other users, shut down or reboot the machine, etc.

**superuser do (SUDO)**: Command that lets regular users temporarily run commands with superuser (root) privileges.

**sudoers**: Configuration file that controls who can use sudo and which commands they can run.

**logfile**: Specifies the path to the file that records which sudo commands were run.

**iolog_dir**: Specifies the path to subdirectory that records the input and output of sudo commands.

**requiretty**: Forces sudo commands to be run only from a real terminal (TTY – teletypewriter), ie interactively from a terminal but not from a non-interactive shell, script or automated process (like a cron job).

**secure_path**: Defines which directories are searched for executables when using sudo, to prevent inhering the user’s environmental path and running programmes or scripts from unexpected or unsafe directories. Sudo can still run an executable from outside the path, but must specify its full or relative path.

**Why use sudo instead of logging in as root?**
* Safer: you don’t need to share or use root password directly.
* Auditable: all sudo commands can be logged.
* Limited access: you can restrict what commands regular users can run.
* Prevents accidental system-wide damage from casual mistakes.

**Useful commands**:
* `(sudo) su` - switch to root user.
* `adduser <username> sudo` - give sudo privileges to a user.
* `sudo -l` - check sudo privileges.
* `sudo <command>` - run a command as root.
* `sudo visudo` - edit `sudoers` safely, checking the syntax before saving and preventing mistakes that could lock you out of sudo access.
* `sudo cat /var/log/sudo/sudo.log` - check the log of sudo commands.

---
## UFW (Uncomplicated Firewall)

**Firewall**: Security system (software or hardware) that controls incoming and outgoing network traffic based on a set of rules. It protects the system or network from unauthorized access and malicious traffic.

**UFW (Uncomplicated Firewall)**: User-friendly interface or frontend for managing the built-in firewall on Linux (**iptables** or **nftables**). It is not a firewall itself, but a tool that simplifies the use of the system’s firewall.

**Useful commands**:
* `sudo apt install ufw` - install UFW.
* `sudo ufw status` - show current UFW rules.
* `sudo ufw status numbered` - show current UFW rules in an ordered list.
* `sudo ufw enable` - enable UFW.
* `sudo ufw allow <port>` - allow port.
* `sudo ufw deny <port>` - deny port.
* `sudo ufw delete <rule_number>` - delete rule.

---
## SSH (Secure Shell)

Network protocol that allows a secure connection from one computer (client) to another (usually a server) over a network. SSH is secure because it encrypts everything between computers (such as login credentials and all commands and data transferred).

**OpenSSH**: Most widely used open-source implementation of the SSH protocol.

**Network Address Translation (NAT)**: Default network mode in VirtualBox that allows the VM to access the internet but keeps it hidden from the rest of the network. It doesn’t allow any direct connections into the VM from the host, unless through port forwarding.

**Port**: Access point through which data enters or leaves a computer over a network.

**Port forwarding**: Gives the host access to services inside the VM by forwarding a port on the host machine to a port on the VM.

**Useful commands**:
* `sudo apt install openssh-server` - install OpenSSH.
* `sudo systemctl status ssh` - check status of ssh.
* `sudo nano /etc/ssh/sshd_config` - edit the sshd server configuration file.
* `sudo nano /etc/ssh/ssh_config` - edit ssh client file.
* `sudo systemctl restart ssh` - restart ssh service.
* `ssh <guest_username>@localhost -p 4242` - connect via ssh.

---
## Cron
**Time-based job scheduler** in Unix-like OS, used to automate tasks (**cron jobs**) that run periodically at fixed times, dates, or intervals – like backups, updates, or system maintenance scripts.

Cron runs a **daemon** (**crond**) in the background, which checks cron configuration files (**crontabs**) every minutes. If a job matches the current time, it runs the command.

**Daemon**: background process that runs continuously on a Unix-like system to perform specific tasks or provide services.

**Useful commands**:
* `sudo crontab -u root -e` - edit the crontab for the root user.

**Crontab syntax**:
```
*minute *hour *day of month *month *day of week
*/interval
```

---
## Monitoring Script

Stored in `/etc/monitoring.sh`.

**System architecture**:
* `uname -a` - displays available system information about the machine and kernel in one line.

**Number of physical and virtual processors**:

**CPU (Central Processing Unit, aka processor)**: the brain of the computer – it performs all the instructions and calculations that make programmes and the OS run.
* **physical**: real hardware chip installed on the motherboard;
* **virtual**: software abstraction of a CPU, found in VMs, which can share physical hardware.
* `/proc/cpuinfo`: stores detailed info about each CPU.

**Current available RAM on your server and its utilization rate as a percentage**:

**RAM (Random Access Memory)**: computer’s short-term memory. It temporarily stores data and instructions that the CPU needs right now or in a very near future. Unlike a hard drive (which stores data long-term), RAM loses all data when the computer is turned off.
* `free --mega` - displays system memory usage in megabytes.

**Current available storage on your server and its utilization rate as a percentage**:
* `df` - displays info about disk space usage on mounted filesystems.
* `-h` - sizes are displayed in readable format like MB and GB instead of raw bytes.
* `--total` - adds a summary line at the end that combines all filesystems.

**Current utilization rate of your processors as a percentage**:
* `top` - shows real-time dynamic view of running processes and system resource usage (updates every few seconds).
* `-b` - runs `top` in batch mode, outputting data once and then exits.
* `-n1` - specifies the number of iterations `top` should run.

**Date and time of the last reboot**:
* `who -b` - displays the last system boot time.

**Whether LVM is active or not**:
* `grep -q` - runs grep in quiet or silent mode, without producing output. Exit status 0 if match is found (true) and 1 if not found (false).

**Number of active connections**:

**Internet socket**: software endpoint used for sending and receiving data across a network – virtual plug that connects a computer to another.
* `/proc/net/sockstat`: stores statistics about network sockets.

**Number of users using the server**:
* `who` - shows info about users currently logged into the system.

**IPv4 address of your server and its MAC (Media Access Control) address**:

**IP address**: logical address used to identify a device on a network – can change depending on network configuration. IPv4: most common format, 32-bit, 4 numbers.

**MAC address**: physical address burned into the computer’s network card (ethernet or wi-fi) – permanent and unique to hardware.

* `hostname -I` - displays the IP addresses assigned to the current host (computer).
* `ip link` - displays information about network interfaces.

**Number of commands executed with the sudo program**:
* `/var/log/sudo/sudo.log`: stores the log of all commands used with sudo (as defined in sudoers).

`wall` (write all): sends a message to all logged-in users’ terminals on a Linux system.