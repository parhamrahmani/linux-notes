## Using zsh for autocompleting and other features

### Install zsh
- using apt for debian based systems
```bash
sudo apt install zsh
```
- using yum for redhat based systems
```bash
sudo yum -y install zsh
```
#### see which shell you are using
```bash
echo $0
```
#### switch to zsh
```bash
chsh -s $(which zsh)
```
####  switch back to bash
```bash
chsh -s $(which bash)
```
##### `Problem: Oracle Linux WSL(version 2) doesn't have chsh, do the following:`
```bash
sudo yum install util-linux-user passwd
```
Then use `which` to verify that chsh is installed and find its path
```bash
which chsh
```

### Install oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
#### select a theme
```bash
nano ~/.zshrc
```
edit the line `ZSH_THEME="robbyrussell"` to `ZSH_THEME="agnoster"` or any other theme you like.

```
ZSH_THEME="agnoster"
```
see [here](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#agnoster)
then refresh the terminal
```bash
source ~/.zshrc
```
### Useful Plugins
#### [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
Add the plugin to the list of plugins for Oh My Zsh to load (inside ~/.zshrc)
```bash
vi ~/.zshrc
```
press `i` to enter insert mode and add `zsh-autosuggestions` to the plugins list
```
plugins=(git zsh-autosuggestions)
```
press `esc` then `:wq` to save and exit.
then refresh the terminal
```bash
source ~/.zshrc
```
#### [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
install the package
- for redhat based systems
```bash
sudo cd /etc/yum.repos.d/
sudo wget https://download.opensuse.org/repositories/shells:zsh-users:zsh-syntax-highlighting/RHEL_7/shells:zsh-users:zsh-syntax-highlighting.repo
sudo yum install zsh-syntax-highlighting
```
enable the plugin in `~/.zshrc`
```bash
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
```
**or** 
```bash	
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```
then add the plugin to the list of plugins for Oh My Zsh to load (inside ~/.zshrc)
```bash
vi ~/.zshrc
```
press `i` to enter insert mode and add `zsh-syntax-highlighting` to the plugins list
```
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```
press `esc` then `:wq` to save and exit.

then refresh the terminal
```bash
source ~/.zshrc
```
#### [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)
install the package
```bash
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
```
then add the plugin to the list of plugins for Oh My Zsh to load (inside ~/.zshrc)
```bash
vi ~/.zshrc
```
press `i` to enter insert mode and add `zsh-autocomplete` to the plugins list
```
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)
```
press `esc` then `:wq` to save and exit.

then refresh the terminal
```bash
source ~/.zshrc
```