{
  programs.nixvim.opts = {
    autoindent = true; # Do clever autoindenting
    backspace = "indent,eol,start"; # allow backspace on
    clipboard = "unnamedplus"; # sync clipboard between os and neovim
    cmdheight = 1; # more space in the neovim command line for displaying messages
    colorcolumn = "100"; # Columns to highlight
    conceallevel = 0; # so that `` is visible in markdown files
    cursorcolumn = false; # Highlight the screen column of the cursor
    cursorline = false; # Highlight the screen line of the cursor
    expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
    fileencoding = "utf-8"; # File-content encoding for the current buffer
    foldlevel = 99; # Folds with a level higher than this number will be closed
    hidden = true; # Keep closed buffer open in the background
    hlsearch = false; # set highlight on search
    ignorecase = true; # When the search query is lower-case, match both lower and upper-case
    inccommand = "split"; # Search and replace: preview changes in quickfix list
    incsearch = true; # Incremental search: show match for partly typed search command
    laststatus = 3; # When to use a status line for the last window
    linebreak = true; # companion to wrap don't split words
    modeline = true; # Tags such as 'vim:ft=sh'
    modelines = 100; # Sets the type of modelines
    mouse = "a"; # Enable mouse control
    mousemodel = "extend"; # Mouse right-click extends the current selection
    number = true; # Display the absolute line number of the current line
    pumheight = 10; # popup menu height
    relativenumber = true; # Relative line numbers
    scrolloff = 4; # Number of screen lines to show around the cursor
    shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
    showmode = false; # do not see things like -- INSERT -- anymore
    showtabline = 2; # show tabline always
    sidescrolloff = 8; # minimal number of screen columns either side of cursor if wrap is `false`
    signcolumn = "yes"; # Whether to show the signcolumn
    smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper
    softtabstop = 2; # Number of spaces that a tab counts for while performing editing operations
    spell = false; # Highlight spelling mistakes (local to window)
    splitbelow = true; # A new window is put below the current one
    splitright = true; # A new window is put right of the current one
    swapfile = false; # Disable the swap file
    tabstop = 2; # Number of spaces a <Tab> in the text stands for (local to buffer)
    termguicolors = true; # Enables 24-bit RGB color in the |TUI|
    textwidth = 0; # Maximum width of text that is being inserted.  A longer line will be broken after white space to get this width.
    timeoutlen = 300; # time to wait for a mapped sequence to complete (milliseconds)
    undofile = true; # Automatically save and restore undo history
    updatetime = 250; # Faster completion
    wrap = false; # Prevent text from wrapping
  }; 
}
