
autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
set termguicolors
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=10
" set noshowmode
set signcolumn=yes
set isfname+=@-@
" set ls=0
set mouse=a
" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set wrap linebreak nolist
" set colorcolumn=100

"highlight NvimTreeFolderIcon guibg=blue

call plug#begin()

Plug 'github/copilot.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-commentary'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'kabouzeid/nvim-lspinstall'

" Plug 'glepnir/lspsaga.nvim'
Plug 'tami5/lspsaga.nvim'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'sbdchd/neoformat'
" Initialize plugin system
"
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

Plug 'tpope/vim-surround'
Plug 'pantharshit00/vim-prisma'

call plug#end()

colorscheme onedark
" colorscheme nvcode 


lua require("mario")
" lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

let mapleader = " "
let g:neoformat_try_formatprg = 1
set completeopt=menuone,noselect
let g:rust_clip_command = 'xclip -selection clipboard'

syntax enable
" syntax on
filetype plugin indent on


" imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true

nmap('<Leader>ca', ':lua MyTelescopeLspCodeActions()<CR>')

let g:syntastic_rust_checkers = ['cargo']
let g:cargo_shell_command_runner = '!'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']


nnoremap <leader>fc :Neoformat<cr>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>



inoremap <C-s> <esc>:w<cr>
nnoremap <C-a> ggVG
nnoremap <C-s> :w<cr>

nnoremap <leader><Right> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>


nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" nnoremap <leader>k :bNext<cr>
" nnoremap <leader>j :bprevious<cr>
" nnoremap <leader>fc :bdelete<cr>
nnoremap <leader><Up> :bNext<cr>
nnoremap <leader><Down> :bprevious<cr>
nnoremap <leader>f<Left> :bdelete<cr>

noremap <Leader>y "*y
vnoremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
vnoremap <Leader>Y "+y
noremap <Leader>P "+p
"nnoremap <leader>y "+y
"vnoremap <leader>y "+y
"nmap <leader>Y "+Y 
vnoremap <C-Up> :m '>+1<CR>gv=gv
vnoremap <C-Down> :m '<-2<CR>gv=gv



fun! LspLocationList()
    " lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
endfun

nnoremap <leader>gb <C-O>
nnoremap <leader>gf <C-I>


nnoremap <leader>rh :RustHoverActions<CR>

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gs :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>grn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>gsd :lua vim.diagnostic.show() <CR>
" nnoremap <leader>gss :lua vim.lsp.buf.symbols()<CR>
"// lua vim.lsp.diagnostic.show_line_diagnostics()
nnoremap <leader>gn :lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>gm :lua vim.diagnostic.goto_prev()<CR>
nnoremap <leader>sd :lua vim.diagnostic.open_float()<CR>
" nnoremap <leader>ss :lua vim.diagnostic.get()<CR>
nnoremap <leader>gll :call LspLocationList()<CR>


nnoremap <leader>td :Telescope diagnostics<CR>
nnoremap <leader>tr :Telescope lsp_references<CR>
nnoremap <leader>tca :Telescope lsp_code_actions<CR>


nnoremap <leader>se :Lspsaga show_line_diagnostics<CR>
nnoremap <leader>ce :Lspsaga yank_line_diagnostics<CR>
nnoremap <leader>sca :Lspsaga code_action<CR>
nnoremap <leader>sh :Lspsaga hover_doc<CR>
" nnoremap <leader>e :lua vim.lsp.diagnostic.open_float()<CR>
" vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
" vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
" vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
" vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)


nnoremap <A--> :vertical resize -10<CR>
nnoremap <A-=> :vertical resize +10<CR>
" " -- show hover doc
" nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" " -- or use command
" nnoremap <silent>K :Lspsaga hover_doc<CR>

" " -- scroll down hover doc or scroll in definition preview
" nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" " -- scroll up hover doc
" nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" nnoremap <silent> gh :Lspsaga lsp_finder<CR>
" nnoremap <silent><leader>ca :Lspsaga code_action<CR>
" vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" autocmd CursorHold * lua vim.lsp.buf.document_highlight()
" autocmd CursorMoved * lua vim.lsp.buf.clear_references()

augroup THE_M
    " autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
    " autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
    " autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()

    autocmd!
    autocmd! BufWrite,BufEnter,InsertLeave * :call LspLocationList()
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 50})
augroup END

augroup NeoformatAutoFormat
    autocmd!
    autocmd FileType javascript setlocal formatprg=prettier\
                                             \--stdin\
                                             \--print-width\ 80\
                                             \--single-quote\
                                             \--trailing-comma\ es5
    autocmd BufWritePre *.js,*.jsx Neoformat
augroup END

