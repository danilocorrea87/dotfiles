" Desativa compatibilidade com VI
set nocompatible

set autoindent

" Ativa detectação de tipo de arquivo. O Vim poderá tentar detectar o tipo de
" arquivo em uso.
" filetype on

" Ativa plugins e carregue o plugin para o tipo de arquivo detectado.
filetype plugin on

" Carrega indentação de um arquivo para um tipo de arquivo detectado.
" filetype indent on

" Ativa highlighting de syntax.
syntax on

" Permite retrocesso sobre recuo, quebras de linha e início de inserção.
set backspace=indent,eol,start

" Add números a cada linha do lado esquerdo.
set number

" Realce a linha do cursor abaixo do cursor horizontalmente.
set cursorline

" Defina a largura do deslocamento para 4 espaços.
set shiftwidth=4

" Defina a largura da guia para 4 colunas.
set tabstop=4

" Use caracteres de espaço em vez de tabulações.
set expandtab

" Não enrole linhas. Permita que as linhas longas se estendam até onde a linha vai.
set nowrap

" Ao pesquisar em um arquivo, realce incrementalmente os caracteres correspondentes à medida que você digita.
set incsearch

" Use o realce ao fazer uma pesquisa.
set hlsearch

" Defini encode para utf8
set encoding=utf8

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ryanoasis/vim-devicons'
Plugin 'Yggdroot/indentLine'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mhartington/oceanic-next'
Plugin 'arcticicestudio/nord-vim'
Plugin 'kaicataldo/material.vim', { 'branch': 'main' }
Plugin 'StanAngeloff/php.vim'

" Terraform
Plugin 'hashivim/vim-terraform'
Plugin 'vim-syntastic/syntastic'
Plugin 'juliosueiras/vim-terraform-completion'

call vundle#end()

filetype plugin indent on

" Configurações do NERDTree

" Ativando arquivos ocultos
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', '\.history$']
" Abre o NERDTree por padrão
autocmd VimEnter * NERDTree | wincmd p

" Atalho para abrir e fechar o NERDTree
map <C-n> :NERDTreeToggle<CR>

" Fecha o NERDTree se o NEERDTree for ultima janela restante
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Configuração dos icones de git no NERDTree

let g:NERDTreeDirArrowExpandable = '✚'
let g:NERDTreeDirArrowCollapsible = '➜'
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'✹',
    \ 'Staged'    :'✚',
    \ 'Untracked' :'✭',
    \ 'Renamed'   :'➜',
    \ 'Unmerged'  :'═',
    \ 'Deleted'   :'✖',
    \ 'Dirty'     :'✗',
    \ 'Ignored'   :'☒',
    \ 'Clean'     :'✔︎',
    \ 'Unknown'   :'?',
    \ }

" Configurações vim-airline

let g:airline_theme = 'material'
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name:w

" Configuração do plugin de indentação
let g:indentLine_enabled = 1

" Configuração do tema

" for vim 8
if (has("termguicolors"))
    set termguicolors
endif

let g:material_theme_style = 'darker'

colorscheme material

" Configuração dos plugins do terraform

" Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0
