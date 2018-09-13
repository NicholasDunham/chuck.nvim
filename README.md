# chuck.nvim

A Neovim plugin for [ChucK](http://chuck.stanford.edu/), a programming language
for real-time sound synthesis and music creation. Currently supports syntax
highlighting and controling the Chuck VM (e.g. starting/stopping shreds).

This is a modified version of [Andy Wilson's chuck.vim
plugin](https://github.com/wilsaj/chuck.vim). It meets my needs, but the
original version might work better for you. Here are the differences:

* Expects you to start ChucK in loop mode yourself, rather than starting it for
  you in a Vim split.
* Uses [Neovim](https://neovim.io)'s `jobstart()` function to send commands to
  ChucK, instead of depending on
  [vimproc](https://github.com/Shougo/vimproc.vim). This means it's
  Neovim-specific—it won't work in Vim, even if you're using the latest version
  and/or have vimproc installed.
* Does not map its functions to any keys by default. Recommended bindings are
  listed below.
* Enables more granular control of ChucK shreds. The original plugin could only
  add a shred (from the current buffer), whereas this one can also replace
  a shred (also using the current buffer), remove a shred (by number), and
  clear all active shreds. See below for details on these functions.


## Installation

This plugin is compatible with Vim plugin managers like
[vundle](https://github.com/gmarik/vundle),
[pathogen](https://github.com/tpope/vim-pathogen/), and
[vim-plug](https://github.com/junegunn/vim-plug). The simplest way to get it
installed is to use one of those. Consult your plugin manager's documentation
for details.

## Usage

Chuck.nvim makes no attempt to start or stop the ChucK VM. You'll need to start
it up yourself before running any of the plugin's functions. I like to have
ChucK running in a separate Tmux pane.

### Available Functions

Chuck.nvim provides the following functions to interact with the ChucK VM:

**ChuckStatus()**<br>Prints the ChucK VM's current status (time and active
shreds). The status is printed to the window the ChucK VM is running in, *not*
within Neovim. If ChucK is not running in a visible window (for example, if you
started ChucK by typing `chuck --loop &`), this command will have no effect.

**ChuckAddShred()**<br>Sends the filename of the currently active buffer to the
ChucK VM, to be added as an active shred. If the current buffer has unsaved
changes, those changes will not be sent to ChucK. If the current buffer is
unnamed, nothing will be sent to ChucK.

**ChuckRemoveShred()**<br>Prompts the user for a shred number, then removes
that shred from the ChucK VM. To get the number of a shred to remove, use the
`ChuckStatus()` function.

**ChuckClearShreds()**<br>Removes all active shreds, but keeps the ChucK VM
running.

**ChuckReplaceShred()**<br>Prompts the user for a shred number, then replaces
that shred with the currently active file. Like `ChuckAddShred()`, this just
sends the name of the current file to the ChucK VM, meaning unsaved changes
will not be sent to ChucK. Like `ChuckRemoveShred()`, it assumes that you know
the number of the shred you want to replace, probably because you called
`ChuckStatus()` before calling `ChuckReplaceShred()`.

### Mapping Functions to Keystrokes

Chuck.nvim does not map any of its functions by default. You'll need to create
maps in your `.vimrc` file, using mappings that make sense to you and don't
conflict with any other mappings you use. If you don't have a preference,
you're welcome to use mine:

```vim
nnoremap <leader>^ :call ChuckStatus()<CR>
nnoremap <leader>+ :call ChuckAddShred()<CR>
nnoremap <leader>- :call ChuckRemoveShred()<CR>
nnoremap <leader>_ :call ChuckClearShreds()<CR>
nnoremap <leader>= :call ChuckReplaceShred()<CR>
```


## Future Plans

I'd like to streamline the shred management flow. Currently, removing or
replacing a shred involves calling `ChuckStatus()`, reading the results to find
the shred you're interested in, running the command, and entering the number of
the shred. That's too many steps. I'd like to make it possible to update
a shred just by saving it, for example, or remove a shred by closing its
buffer. Currently these things aren't possible because ChucK doesn't return
a shred number when it adds a shred, even when verbosity is set to 10. I'm
thinking through some ways to solve this problem, but since my ChucK skills
aren't yet at the point where realtime control is necessary, it's not
a priority.
