dotfiles
=========

Dot files I use regularly for things like Vim, Tmux, etc...

If you use the gitconfig, remember to change the name and email properties. 

Installation
============

This repo includes scripts to make a selfisntall tarball of the dotfiles. This 
allows you to run the tarball on a new system and have the dotfiles installed
right into the home directory of the user running the tarball. 

To build this executable, simply run the build script: 

  ./build.sh 

Then to install, run the install-dotfiles executable that was created on the new
system: 

  ./install-dotfiles 

Configs Included
================

Currently included are: 
 * tmux
   - Tmux configuration file 
   - A small script to display Caps Lock and Num
     Lock status on the status bar in tmux. 
 * Vim 
   - vimrc and .vim directory containing NERDTree and Supertab plugins. 
 * bashrc 
 * gitconfig
