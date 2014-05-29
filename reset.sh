#!/bin/bash
txt="(display.config.bootscreen)"
echo "display.udp.alltxt $txt"
echo "display.udp.alltxt $txt"|lua -l display
