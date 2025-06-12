clipboard() {
    if [ -t 0 ]; then
        # No stdin pipe, so output clipboard content
        pbpaste
    else
        # Stdin pipe exists, so copy to clipboard
        pbcopy
    fi
}
