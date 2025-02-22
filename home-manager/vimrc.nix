let dotVimRaw = ''
    let mapleader=" "
    " set langmap=yh,hy,nj,jn,ek,ke,ol,lo,YH,HY,NJ,JN,EK,KE,OL,LO
    nnoremap y h
    nnoremap h y
    nnoremap n j
    nnoremap j n
    nnoremap e k
    nnoremap k e
    nnoremap o l
    nnoremap l o


    nnoremap Y H
    nnoremap N J
    nnoremap J N
    nnoremap E K
    nnoremap K E
    nnoremap O L
    nnoremap L O


    xnoremap y h
    xnoremap h y
    xnoremap n j
    xnoremap j n
    xnoremap e k
    xnoremap k e
    xnoremap o l
    xnoremap l o


    onoremap h y
    onoremap y h


    nnoremap <C-d> <del>
    inoremap <C-l> <ESC>
    inoremap <C-,> <Left>
    inoremap <C-.> <Right>
    inoremap <C-S-lt> <Down>
    inoremap <C-S->> <Up>

    nnoremap <leader>w :w!<CR>
    nnoremap <leader>q :q!<CR>


    vnoremap < <gv
    vnoremap > >gv

    nnoremap S viw

    set clipboard=unnamedplus
    set clipboard+=unnamed
  '';
  in
{
  home.file.".ideavimrc".text = dotVimRaw;
}
