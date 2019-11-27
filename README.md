# dotfiles

When configuring my new MacBook Pro 16" I decided to use [zsh](https://www.zsh.org/) instead of bash. The main reason
was that [Apple replaced bash with zsh as the default shell in macOS Catalina](https://www.theverge.com/2019/6/4/18651872/apple-macos-catalina-zsh-bash-shell-replacement-features).

As I decided to use [oh-my-zsh](https://ohmyz.sh/) to manage my zsh configuration together with
[starship](https://starship.rs/) as the zsh prompt a `.dotfiles` repository is not really needed anymore.
I could put my `.zshrc` file under source control but as I'm mostly using the default settings I don't see the benefits
(yet). Maybe I will change my mind later when I start experimenting customizing the settings.

Instead this `README` contains steps to setup a new environment.

 * Install [oh-my-zsh]((https://ohmyz.sh/))
 * Install [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting):
   `brew install zsh-syntax-highlighting`
 * Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions):
   `brew install zsh-autosuggestions`
 * To activate the syntax highlighting and autosuggestions, add the following to the end of `~/.zshrc`:
   ```
   source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
   source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
   ```
 * Install [starship](https://starship.rs/): `brew install starship`
 * Add the following to the end of `~/.zshrc`:
   ```
   eval "$(starship init zsh)"
   ```
 * Configure the plugins in `~/.zshrc` like:
   ```
   plugins=(battery docker docker-compose gcloud git git-flow gradle heroku iterm2 mvn node npm sdk vscode)
   ```
   See the list of available plugins [here](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins)
 * Download and install the [Fira Code](https://github.com/tonsky/FiraCode) monospaced font
 * Download the [Atom One Dark](https://github.com/nathanbuchar/atom-one-dark-terminal) color scheme for Terminal and
   iTerm2 (a copy is also stored in this repository)
 * Configure the [Atom One Dark](https://github.com/nathanbuchar/atom-one-dark-terminal/blob/master/scheme/terminal/One%20Dark.terminal)
   color scheme in Terminal
 * Configure the `Fira Code` font in Terminal
 * Download and install the [iTerm2](https://iterm2.com/) terminal
 * Configure the [Atom One Dark](https://github.com/nathanbuchar/atom-one-dark-terminal/blob/master/scheme/iterm/One%20Dark.itermcolors)
   color scheme in iTerm2:
   ```
   Just save it somewhere and open the file. The color settings will be imported into iTerm2.
   Apply them in iTerm through iTerm → preferences → profiles → colors → load presets.
   ```
   More iTerm2 color schemes can be found on https://iterm2colorschemes.com/
 * Configure the `Fira Code` font in iTerm2 (don't forget to set the non-ASCII font as well and to enable the ligatures)
 * Download and install the [Hyper](https://hyper.is/) terminal
 * Configure the `Fira Code` font and `Atom Dark` plugin in Hyper like:
   ```
   fontSize: 14,
   fontFamily: '"Fira Code", ..',
   plugins: [
     'hyperterm-atom-dark'
   ],
   ```


Happy coding!!


Oh, and of course don't forget to install the [Aerial](https://github.com/JohnCoates/Aerial) screensaver.
