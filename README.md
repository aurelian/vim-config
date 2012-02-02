#### My vim configs

Install:

    git clone git://github.com/aurelian/vim-config.git ~/.vim
    ln -s ~/vimrc ~/.vimrc

Some mappings in [vimrc](vim-config/blob/master/vimrc) are MacOS specific.

#### Stuff I should use more often

* <code>##</code> in cmd adds current path

* <code>cmd-cr</code> toggles fullscreen (in mvim)

* <code>:set (no)list</code> #=> hides/shows tabs and enters #=> usefull to detect spaces vs tabs

* <code>cmd-e</code> #=> toggles <code>:set paste</code>

* lead is <code>,</code>

##### Netrw - File Explorer [vimcast](http://vimcasts.org/e/15)

<code>:vsp .</code> #=> vertical split in cwd

<code>:Vex .</code> #=> vertical split in file folder

New file: <code>%</code>

New folder: <code>d</code>

<code>o</code> enter file/folder in horizontal split
<code>v</code> enter file/folder in vertical split
<code>t</code> enter file/folder in new tab

#### Plugins

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

  Command is set to: <code>ack -H --nocolor --nogroup --column --ruby</code>

* [vim-rails](https://github.com/tpope/vim-rails)

#### Syntax

* [vim-handlebars](https://github.com/nono/vim-handlebars)

* [vim-coffee-script](https://github.com/kchmck/vim-coffee-script)

* [scss-syntax.vim](http://github.com/cakebaker/scss-syntax.vim)

* [textile.vim](https://github.com/timcharper/textile.vim)

  <code>:TextilePreview</code> # => previews the buffer

* [vim-markdown](https://github.com/tpope/vim-markdown)

#### Colors

* [solarized](http://github.com/altercation/vim-colors-solarized) default

* [mayansmoke](https://github.com/vim-scripts/mayansmoke)

