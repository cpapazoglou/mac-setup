echo
echo "> Setting up shell"

presto_dir="${ZDOTDIR:-$HOME}/.zprezto"

if [ -d "$presto_dir" ]; then
  echo ">> Updating prezto"
  git -C $presto_dir pull
  git -C $presto_dir submodule update --init --recursive
else
  echo ">> Setting up prezto"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$presto_dir"
  
  for rcpath in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/*; do
    rcfile=`basename $rcpath`
    if [ "$rcfile" != "README.md" ]; then
      ln -s "$rcpath" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    fi
  done
fi

finger karun | grep -q "Shell: /bin/zsh"
if [ $? != 0 ] ;then
  echo ">> Changing default shell to zsh."
  chsh -s /bin/zsh
fi

echo ">> Remove symlink to current .zshrc file"
rm -f "${ZDOTDIR:-$HOME}/.zshrc"
echo ">> Replace with symlink to in-project .zshrc file. Open a new shell for scripts to take effect."
ln -s $PWD/shell/zshrc "${ZDOTDIR:-$HOME}/.zshrc"