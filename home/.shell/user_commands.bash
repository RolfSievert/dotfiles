#! /bin/bash
#
# A place for your custom shell functions
#

fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || mimeopen "$file" & disown
  fi
}

vf() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || nvim "$file"
  fi
}

folder_items() {
    # TODO print tree structure
    sudo du -ax --block-size=1M "$1" | sort -n | tail -50
}

sum_sizes() {
    numfmt --from=auto | awk '{s+=$1} END {print s}' | numfmt --to=iec-i
}

package_sizes_all() {
    sizes=$(pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h)
    # extract sizes without byte suffix
    total=$(echo "$sizes" | cut -d' ' -f1 | cut -d'B' -f1 | sum_sizes)

    echo "$sizes\n\nTotal: ${total}B"
}

package_sizes() {
    sizes=$(pacman -Qei | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h)
    # extract sizes without byte suffix
    total=$(echo "$sizes" | cut -d' ' -f1 | cut -d'B' -f1 | sum_sizes)

    echo "$sizes\n\nTotal: ${total}B"
}

nn() {
    gnome-terminal --working-directory=$(pwd) >/dev/null &
}

ptop() {
    sudo powertop --auto-tune -r && firefox powertop.html && rm powertop.html
}
