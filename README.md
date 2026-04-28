# Moonshine
A basic setup meant to allow for the use of sunshine and moonlight to use a device as a second monitor over a dedicated cable connection.

The operating theory is quite simple, by using a usb-tether between the phone and the laptop isolated within a namespace, the data for sharing the laptop screen can be sent reliably between sunlight and moonshine without affecting the wifi network being used by the laptop, and thus allowing sunshine and moonlight to work together completely offline.

This system is currently setup and tested working for Arch linux with hyprland and a samsung zfold5 running sunshine and moonlight respectively.

Instructions for use:

plug phone into computer.

enable usb tether mode on phone.

run "ip addr" to find which network device is associated with your phone, and ensure the "Iface" command is set accordingly in the code.

run moonshine.sh as sudo.
