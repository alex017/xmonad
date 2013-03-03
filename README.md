# Xmonad

### Install GHC

    $ sudo aptitude install ghc libghc6-network-dev libghc6-mtl-dev zlib1g-dev

### Install X11 libraries

    $ sudo aptitude install libx11-dev libxft-dev x11-utils libxinerama-dev
_Typically you need:_ `libXinerama, libXext, libX11`
### Cabal-install
* Download [Cabal-install](http://hackage.haskell.org/packages/archive/cabal-install/)

* Run the bootstrap script to install cabal-install
```
    $ tar xzf cabal-install-x.x.x.tar.gz
    $ cd cabal-install-x.x.x/
    $ ./bootstrap.sh
```
* Make sure to add `~/.cabal/bin`  to your patch (I do this via this next line in my .bashrc)
```
    export PATH="$HOME/.cabal/bin:$PATH"
```
### Now we install xmonad
```
    $ cabal update
    $ cabal install xmonad
    $ cabal install xmonad-contrib
    $ cabal install xmobar --flags="with_utf8" --flags="with_xft"
```

### Add `xmonad.desktop` in the `/usr/share/xsessions` directory


### Making xmonad your default window manager

    $ sudo ln -s /home/username/.cabal/bin/xmonad /usr/bin/xmonad

verify that it is now the default

    $ sudo update-alternatives --query x-session-manager

add xmonad

    $ sudo update-alternatives --install /usr/bin/x-session-manager x-session-manager /usr/bin/xmonad 50

and change

    $ sudo update-alternatives --config x-session-manager
    
### Default keyboard bindings

`mod-shift-return` - Launch terminal

`mod-p` - Launch dmenu

`mod-shift-p` - Launch gmrun

`mod-shift-c` - Close the focused window

`mod-space` - Rotate through the available layout algorithms

`mod-shift-space` - Reset the layouts on the current workspace to default

`mod-n` - Resize viewed windows to the correct size

`mod-tab` - Move focus to the next window

`mod-j` - Move focus to the next window

`mod-k` - Move focus to the previous window

`mod-shift-j` - Swap the focused window with the next window

`mod-shift-k` - Swap the focused window with the previous window

`mod-h` - Shrink the master area

`mod-l` - Expand the master area

`mod-shift-q` - Quit xmonad

`mod-q` - Restart xmonad

`mod-[1..9]` - Switch to workspace N

`mod-shift-[1..9]` - Move client to workspace N

`mod-{w,e,r}` - Switch to physical/Xinerama screens 1, 2, or 3
