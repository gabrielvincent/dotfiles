set --query nvm_mirror || set --global nvm_mirror https://nodejs.org/dist
set --query XDG_DATA_HOME || set --local XDG_DATA_HOME ~/.local/share
set --global nvm_data $XDG_DATA_HOME/nvm

function _nvm_install --on-event nvm_install
    test ! -d $nvm_data && command mkdir -p $nvm_data
    echo "Downloading the Node distribution index..." 2>/dev/null
    _nvm_index_update
end

function _nvm_update --on-event nvm_update
    set --query --universal nvm_data && set --erase --universal nvm_data
    set --query --universal nvm_mirror && set --erase --universal nvm_mirror
    set --query nvm_mirror || set --global nvm_mirror https://nodejs.org/dist
end

function _nvm_uninstall --on-event nvm_uninstall
    command rm -rf $nvm_data

    set --query nvm_current_version && _nvm_version_deactivate $nvm_current_version

    set --names | string replace --filter --regex -- "^nvm" "set --erase nvm" | source
    functions --erase (functions --all | string match --entire --regex -- "^_nvm_")
end

# Function to read and use .nvmrc file
function _nvm_auto_use --description 'Auto use node version defined in .nvmrc'
    if test -f .nvmrc
        set -l node_version (cat .nvmrc | string trim)
        if test "$node_version" != "$nvm_current_version"
            nvm use $node_version
        end
    end
end

# Run on directory change
function _nvm_dir_change --on-variable PWD
    _nvm_auto_use
end

# Run on initialization if interactive
if status is-interactive
    # First try .nvmrc
    _nvm_auto_use
    # If no .nvmrc found, use default version if set
    if test ! -f .nvmrc && set --query nvm_default_version && ! set --query nvm_current_version
        nvm use --silent $nvm_default_version
    end
end
