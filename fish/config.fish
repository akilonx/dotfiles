if status is-interactive
    # Commands to run in interactive sessions can go here
    #fish_config theme choose "Dracula Official"  
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


    # Paths
    set -x PATH /opt/nvim-linux64/bin $PATH
    set -x PATH $PATH /home/akilon/.local/kitty.app/bin
    set -x PATH $PATH /home/akilon/.config/kitty

    # Source Cargo environment
    #source $HOME/.cargo/env

    # Volta configuration
    set -x VOLTA_HOME $HOME/.volta
    set -x PATH $VOLTA_HOME/bin $PATH

    # Aliases
    function kittens
        kitty --session $argv
    end

    # Node.js options
    set -x NODE_OPTIONS "--max-old-space-size=4096"

    # AWS profile
    set -x AWS_PROFILE bookipi

end
