#!/bin/zsh
if [ -f ~/config/tools.sh ]; then
  source ~/config/tools.sh
fi

if [ -f ~/config/help.sh ]; then
  source ~/config/help.sh
fi

# A
# B
# C
alias config='cd ~/config'
# D
# E
# F
fluv() { cd_with_fzf ~/Desktop/Fluv; }
# G
# H
# I
# J
# K
# L
# M
my() { cd_with_fzf ~/Desktop/My; }
# N
# O
# P
# Q
# R
# S
# T
tarode() { cd_with_fzf ~/Desktop/Tarode; }
# U
# V
# W
# X
# Y
# Z

echo "🚀Lucien alias setup complete!"
