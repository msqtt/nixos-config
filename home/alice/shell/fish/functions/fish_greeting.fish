function fish_greeting
  set_color -i magenta;
  echo "Today is $(date)" | cowsay  -fsmall -d
  set_color normal;
end
