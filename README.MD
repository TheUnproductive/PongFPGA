# Pong FPGA realization

This repository tries to implement the original Pong arcade game from scratch on a FPGA Board.

## 1. Requirements

- [ ] 1.1. The game should be playable on a VGA monitor
- [ ] 1.2. The game should be playable with a joystick
- [ ] 2.1. The target hardware is a [Terasic DE10-Lite](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=234&No=1021#contents) board

## 2. Original Pong Design

The idea for this project came to me after seeing the original hardware design for the Pong arcade game. The original design is a very simple design, which is why I wanted to try to implement it on a FPGA board.

I have included the original schematic for the Pong arcade game in this repository and a split up schematic into different features, so that it is easier to understand what is happening.

[Original Schematic](documents/PongSchematics.pdf)

![Original Schematic split up by feature](images/280208060_703291284123364_857021276321443049_n.jpg)

## 3. Implementation

### 3.1. VGA

The DE10-Lite board has a VGA port, which is why I decided to use it as a base.

### 3.2. Logic Design