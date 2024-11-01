function nvm_auto --on-variable PWD --description 'Auto change node version based on .nvmrc'
    if test -e .nvmrc
        set node_version (cat .nvmrc)
        # Remove 'v' prefix if present
        set node_version (string replace -r '^v' '' -- $node_version)

        # Check if the requested version is different from current
        if test "$node_version" != (node -v | string replace -r '^v' '')
            echo "Found .nvmrc with version $node_version"
            nvm use $node_version
        end
    end
end
