function fish_greeting
  if test -n "$IN_NIX_SHELL"
    set_color -i cyan;
    cowsay -fsmall -w "Holy, we're now in a Nix shell!"
  else
    set_color -i magenta;
    echo "Today is $(date)" | cowsay  -fsmall -d
  end
  set_color normal;
end
