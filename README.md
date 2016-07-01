#### My vim configs

Install:

    cd ~
    git clone git://github.com/aurelian/vim-config.git ~/.vim
    git sumbmodule init
    git submodule update
    ln -s ~/.vim/vimrc .vimrc

Some mappings in [vimrc](https://github.com/aurelian/vim-config/blob/master/vimrc) are MacOS specific.

#### Arrows are disabled in NORMAL mode

#### Stuff I should use more often

* leader is <code> </code>

* <code>##</code> in cmd adds current path

* [text object selection](http://vimdoc.sourceforge.net/htmldoc/motion.html#object-select) and vim-surround

* <code>cmd-cr</code> toggles fullscreen (in mvim, same shortcut as in iTerm2)

* <code>:set (no)list</code> ( l) #=> hides/shows tabs and enters

* <code>A</code> goes to end of line and changes to INSERT mode

* <code>o</code> INSERT mode on next line

* <code>$/^0</code> end of line / beggining of line, same as <code>H/L</code>

* paste on next line <code> p</code>

* <code>Ctrl-o</code> / <code>Ctrl-i</code> for jumps in NORMAL mode

* <code>Ctrl-o</code> to run 1 command in INSERT mode

* <code>Ctrl-h</code> / <code>Ctrl-l</code> moves cursor left/right in INSERT mode

* <code>Ctrl-r "</code> paste yanked text in command

* fast vertical resize window <code>,&lt;</code><code>.&gt;</code>

##### Netrw - File Explorer [vimcast](http://vimcasts.org/e/15)

<code>:vsp .</code> #=> vertical split in cwd

<code>:Vex .</code> #=> vertical split in file folder

New file: <code>%</code>

New folder: <code>d</code>

<code>o</code> enter file/folder in horizontal split
<code>v</code> enter file/folder in vertical split
<code>t</code> enter file/folder in new tab

#### Working with splits

 * ```ctrl + w _``` maxout height of current split
 * ```ctrl + w |``` maxout width of current split
 * ```ctlr + w =``` normalize size
 * ```ctlr + w o``` closes all windows but current one
 * ```ctrl + w T``` move split to own tab

#### Plugins

* [vim-dispatch]()

  ```
  F9 mapped to :Dispatch
  :Focus bundle exec rspec " changes Focus to command
  :Dispatch bundle exec rake db:migrate
  ```

* [ctrlp](https://github.com/kien/ctrlp.vim)

  Usage:

  ```
    <c-p>
      <c-t> Open selected file in a new 'tab' after the last tabpage.
      <c-v> Open selected file in a 'vertical' split.
      <c-cr>, <c-s>, <c-x> Open selected file in a 'horizontal' split.
  ```

* [ack](https://github.com/mileszs/ack.vim)

  <code>:Ack stuf*</code>

  Usage:

  ```
      o    to open (same as enter)
      go   to preview file (open but maintain focus on ack.vim results)
      t    to open in new tab
      T    to open in new tab silently
      v    to open in vertical split
      gv   to open in vertical split silently
      q    to close the quickfix window
  ```

