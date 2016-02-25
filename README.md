# Chromium-OS-Overlays

The Same Overlay We are Using to Develop 0.5 

The most recent working Chromium OS overlays for the Raspberry Pi 2 (ChromiumRPI project) https://reddit.com/r/ChromiumRPI/

Chromium OS for Raspberry Pi 2
Initial notes:

    Don't expect to build this and have it work perfectly on a Raspberry Pi, it's a work-in-progress
    This guide will be much easier to follow if you've built Chromium OS before for another platform. If you've having trouble following it, try following the developer guide (linked before) to build an x86-generic image first, and then come back.
    If you want to help out, find us in #ChromiumRPI on Freenode IRC, submit a pull request or message us on reddit.com/r/ChromiumRPI

Prerequisites:

To get started, make sure you have the following:

    a 64-bit build machine, running Ubuntu version 15.04 or 14.04 (better running headless. Other versions/distros might work)
    an account with sudo access
    at least 6GB of RAM (linking Chromium uses about 4GB of your RAM at the same time, so this is another reason not to run any UI or X server in the background if you want to avoid extremely slow builds)
    a fast Internet connection - you'll need to download several gigabytes of source code, if your connection is slow, that won't be fun, especially if you need to re-sync the repo
    sufficient amount of free disk space: 60GB should be the absolute minimum and even with that you could run into problems, 100GB of free space or more is recommended

To give you an idea of how long it takes to complete a build:

    ~10 to 12 hours on a dual core, 4 thread Core i5 Haswell (2014) CPU based machine with SSD and 8GB of RAM
    ~24 hours on lower end (though not Atom based) laptops with a dual core CPU and 6GB of RAM
    a build server (read: non-laptop) with several cores based on current CPU design and at least 16GB RAM is rumored to be able to complete a build within ~2 hours

Get the code:

First, you'll need to download the Chromium OS source code. To learn do so, and also how to setup your environment, check out this link: http://www.chromium.org/chromium-os/developer-guide

Please be aware that you are syncing the bleeding edge source code which can be considered "alpha" when using the instructions given within the developer guide. If you want to be sure to avoid any potential issues during your build process, you will need to check out one of the stable branches. The following example shows how to check out a stable branch - in this case R49, which was the current stable branch at the time of writing:

repo init -u https://chromium.googlesource.com/chromiumos/manifest.git -b release-R49-7834.B
repo sync

You can open the URL https://chromium.googlesource.com/chromiumos/manifest.git/+refs in any browser and check the branches which start with "release-R". Finding out what the current stable ChromeOS release is, shouldn't be difficult (for example, you could just google it, or check the version information on your Chromebook running on the stable channel, if you own one) - once you have found out what the current ChromeOS stable version is, just use the corresponding "release-" branch from that list in order to be sure you're checking out the latest stable code.

Once you've downloaded the code and you've reached the "4.3 Select a board" step, continue below.
Add the overlay:

The raspberrypi overlay is already part of ChromiumOS, although it does not build X or Chromium.

To build for the RaspberryPi2B, you'll need to use the raspberrypi2 overlay provided by this repo. Until this is merged upstream into the Chromium OS project, you'll have to copy it manually across.

Find the folder named "overlays" in the "src" folder of the code you checked out. You'll see a number of folders with names starting "overlay-". Place the overlay-raspberrypi2 folder in this folder alongside the other overlays.

In order to guarantee a working time sync function in the resulting image which you are about to build, you will need to adjust the date that is set via file "overlay-raspberrypi2/chromeos-base/time-sync/files/time.conf" within the overlay. The relevant line starts with "date -s". Adjust the date which is set here to a date/time after the build will be completed. If you don't do this, tlsdate will refuse to sync. If you skip this step, you still have the option to adjust the script in the running build from the dev console later.
Board setup:

You only need to run this once (unless you nuke the chroot):

./setup_board --board=raspberrypi2

If you want to re-create the board root, run:

./setup_board --board=raspberrypi2 --force

You'll probably want to set the "backdoor" password for a development image to let yourself into a shell when the UI isn't working, to do that, use the following command:

./set_shared_user_password.sh

Once prompted, enter a password, then press enter. As above, you only need to do this once.
Patching:

Add "raspberrypi2" to ~/chromiumos/src/third_party/chromiumos-overlay/eclass/cros-board.eclass
Building an image:

Before we can build an image, we need to build all the required packages. Enter the following command to build those (and pray everything compiles):

./build_packages --board=raspberrypi2 --withdev --nowithdebug --nowithtest --nowithautotest

Go get a nice cup of tea, and maybe read a book.

Once all the packages have been successfully built, we can build a USB image by running the following command:

./build_image dev --board=raspberrypi2 --noenable_rootfs_verification

Rebuilding:

According to our experience, building the whole system again after a failed build attempt leads to all kinds of issues, even if the chroot is re-created. Therefore I actually recommend to resync the repo and create the chroot again in case you are about to build the system again: ensure that you first delete the chroot cleanly via cros_sdk --delete within the ~/chromiumos directory. After that you can delete the chromiumos directory via rm -rf.

chromiumos # cros_sdk --delete
chromiumos # cd ..
~ # rm -rf chromiumos

