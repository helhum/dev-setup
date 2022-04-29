if [ -f ~/.profile ]; then
    source ~/.profile
fi

# Use sensible bash
if [ -f ~/.init/sensible.bash ]; then
   source ~/.init/sensible.bash
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type ___git_complete &> /dev/null && [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
    ___git_complete g __git_main;
fi;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# Symfony console commands auto completion
if [ -f ~/.composer/vendor/bin/symfony-autocomplete ]; then
  eval "$(symfony-autocomplete --aliases=c --aliases=dc --aliases=typo3 --aliases=typo3cms --aliases=dt3cms)"
fi;
