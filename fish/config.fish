if status is-interactive
    set -g theme_display_git no
    set -g theme_display_git_dirty no
    set -g theme_display_git_untracked no
    set -g theme_display_git_ahead_verbose yes
    set -g theme_display_git_dirty_verbose yes
    set -g theme_display_git_stashed_verbose yes
    set -g theme_display_git_default_branch yes
    set -g theme_git_default_branches master main
    set -g theme_git_worktree_support yes
    set -g theme_use_abbreviated_branch_name yes
    set -g theme_display_vagrant yes
    set -g theme_display_docker_machine no
    set -g theme_display_k8s_context yes
    set -g theme_display_hg yes
    set -g theme_display_virtualenv no
    set -g theme_display_nix no
    set -g theme_display_ruby no
    set -g theme_display_node yes
    set -g theme_display_user ssh
    set -g theme_display_hostname ssh
    set -g theme_display_vi no
    set -g theme_display_date no
    set -g theme_display_cmd_duration yes
    set -g theme_title_display_process yes
    set -g theme_title_display_path no
    set -g theme_title_display_user yes
    set -g theme_title_use_abbreviated_path no
    set -g theme_date_format "+%a %H:%M"
    set -g theme_date_timezone America/Los_Angeles
    set -g theme_avoid_ambiguous_glyphs yes
    set -g theme_powerline_fonts no
    set -g theme_nerd_fonts yes
    set -g theme_show_exit_status yes
    set -g theme_display_jobs_verbose yes
    set -g default_user your_normal_user
    set -g theme_color_scheme dark
    set -g fish_prompt_pwd_dir_length 0
    set -g theme_project_dir_length 1
    set -g theme_newline_cursor yes
    set -g theme_newline_prompt '$ '
    # Commands to run in interactive sessions can go here
    # set -g theme choose "Dracula Official"
    set -U fish_user_paths /opt/nvim-linux64/bin $fish_user_paths

    # Show git information
    set -g theme_display_git yes

    # Hide user and hostname
    set -g theme_display_user no
    set -g theme_display_hostname no

    # Enable Powerline fonts
    set -g theme_powerline_fonts yes

    # Display the current directory as full path (instead of shortcuts)
    set -g theme_prompt_pwd_dir_length 0
    set -g theme_newline_before_prompt yes

    set -gx NVM_DIR $HOME/.nvm
    if test -s "$NVM_DIR/nvm.sh"
        bass source "$NVM_DIR/nvm.sh"
    end

    # Paths from existing configuration
    set -x PATH /opt/nvim-linux64/bin $PATH
    set -x PATH $PATH /home/akilon/.local/kitty.app/bin
    set -x PATH $PATH /home/akilon/.config/kitty

    # Source Cargo environment
    #source $HOME/.cargo/env

    # Volta configuration
    set -x VOLTA_HOME $HOME/.volta
    set -x PATH $VOLTA_HOME/bin $PATH

    #################################################################
    # Converted from zsh config
    #################################################################


    # Pyenv configuration
    set -gx PYENV_ROOT "$HOME/.pyenv"
    if test -d "$PYENV_ROOT/bin"
        set -gx PATH "$PYENV_ROOT/bin" $PATH
    end
    # Initialize pyenv for fish
    pyenv init - fish | source
    pyenv virtualenv-init - fish | source

    # Prepend local bin to PATH
    set -gx PATH "/Users/akilon/.local/bin" $PATH

    # Alias for python (using python3)
    alias python python3

    # LM Studio CLI tools and Android/Java configuration
    set -gx PATH $PATH "/Users/akilon/.lmstudio/bin"
    set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
    set -gx PATH "$ANDROID_HOME/emulator" "$ANDROID_HOME/tools" "$ANDROID_HOME/tools/bin" "$ANDROID_HOME/platform-tools" $PATH

    # Older Java configuration (commented out)
    #set -gx JAVA_HOME "/usr/local/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
    #set -gx PATH "$JAVA_HOME/bin" $PATH

    set -gx JAVA_HOME "/opt/homebrew/opt/openjdk@11"
    set -gx PATH "$JAVA_HOME/bin" $PATH

    # Apple and fastlane configuration

    fish_config theme choose "Dracula Official"

end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/akilon/.lmstudio/bin
