#!/bin/bash
(ping -c 1 inside >/dev/null && echo BENCH-NET) || 
ip addr show | awk '/inet.*brd/{print \$NF; exit}'
