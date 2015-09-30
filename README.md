# didv beta core

## didv

didv means dispositivo de interface para deficientes visuais, which is portuguese to interface device to the visual impaired.
it's an appliance which allows a blind person to read and write texts.

* the reading part is done through a braille display, which consists in a braille line, a cluster of braille cells (or chars), whose pins are eletro-mecanically activated, in order to deliver content dynamically.
* the writing part is done through a braille keyboard.
* the user also can navigate through the appliance options through a control keyboard.
* didv also allows conversion between non-braille and braille text. it means the user can write text to non-braille readers, and can read non-braille texts in braille format.

didv is a open source / open hardware project, and our purpose is to develop a reliable, autonomous, DIY solution, to widespread culture by an affordable price to people which wouldn't have access to braille material otherwise.

## beta

We have already done a first didv prototype, which we call DIDV Alpha. It works, but it is still very raw, hard to replicate, and intended to show how it works under a engineering approach. Now, we are working in a new prototype, focusing in replication, easy maintenance, a more reliable software, and so on. We call this new version DIDV Beta.

## core

didv software is written in Ruby and C to Raspberry PI and PIC Microcontrollers enviroments. The Ruby part runs into Raspberry Pi. It's divided in three applications: Keyboard Driver, Display Driver and CORE. This is the core application software. It receives data from Keyboard Driver, process it, and dispatches data to the Display Driver.
