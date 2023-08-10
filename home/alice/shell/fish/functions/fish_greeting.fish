function fish_greeting
  if test -n "$IN_NIX_SHELL"
    set_color -i cyan;
    cowsay -fsmall -w "Holy, we're now in a Nix shell!"
  else if test -n "$FHS"
    set_color -i cyan;
    cowsay -fsmall -y "Holy, we're now in a FHS environment!"
  else
    set_color -i magenta;
    echo "Today is $(date)" | cowsay  -fsmall -d
  end
  set_color normal;
end
