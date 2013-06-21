#### My vim configs

Install:

    cd ~
    git clone git://github.com/aurelian/vim-config.git ~/.vim
    ln -s ~/.vim/vimrc .vimrc

Some mappings in [vimrc](https://github.com/aurelian/vim-config/blob/master/vimrc) are MacOS specific.

#### Arrows are disabled in NORMAL mode

#### Stuff I should use more often

* leader is <code>,</code>

* <code>##</code> in cmd adds current path

* <code>cmd-cr</code> toggles fullscreen (in mvim, same shortcut as in iTerm2)

* <code>:set (no)list</code> #=> hides/shows tabs and enters #=> usefull to detect spaces vs tabs

* <code>F6</code> #=> toggles <code>:set paste</code>

* <code>A</code> goes to end of line and changes to INSERT mode

* <code>o</code> INSERT mode on next line

* <code>$/^0</code> end of line / beggining of line

* paste on next line <code>,p</code>

* <code>Ctrl-h</code> / <code>Ctrl-l</code> moves cursor left/right in INSERT mode

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

* [ack](https://github.com/mileszs/ack.vim) / [ag](https://github.com/rking/ag.vim)

  <code>:Ack stuf*</code>

  <code>:Ag stuf*</code>

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

* [vim-rails](https://github.com/tpope/vim-rails)

* [vitality](https://github.com/sjl/vitality.vim)

  (Vit)ality is a plugin that makes (V)im play nicely with (i)Term 2 and (t)mux.

* [closetag](https://github.com/docunext/closetag.vim)

  Auto-close HTML/XML tags.

#### Syntax

* [vim-handlebars](https://github.com/nono/vim-handlebars)

* [vim-coffee-script](https://github.com/kchmck/vim-coffee-script)

* [scss-syntax.vim](http://github.com/cakebaker/scss-syntax.vim)

* [textile.vim](https://github.com/timcharper/textile.vim)

  <code>:TextilePreview</code> # => previews the buffer

* [vim-markdown](https://github.com/tpope/vim-markdown)

* [go.vim](https://github.com/golangtw/go.vim)

#### Colors

* [lucius](https://github.com/jonathanfilip/vim-lucius) default

* [solarized](http://github.com/altercation/vim-colors-solarized)

* [mayansmoke](https://github.com/vim-scripts/mayansmoke)

