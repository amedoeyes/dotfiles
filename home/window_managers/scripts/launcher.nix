{
  writeShellScriptBin,
  lib,
  fzfmenu,
  dex,
}:
writeShellScriptBin "launcher" ''
  DESKTOP_DIRS=()
  IFS=':' read -ra DIRS <<< "$XDG_DATA_DIRS"
  for dir in "''${DIRS[@]}"; do
    DESKTOP_DIRS+=("$dir/applications")
  done

  max_len=$(
    find -L "''${DESKTOP_DIRS[@]}" -type f -name '*.desktop' \
      -exec awk '
        /^Name=/ {
          name = substr($0, index($0, "=") + 1)
          print(length(name))
        }
      ' '{}' \; |
    sort -nr |
    head -1
  )

  entry=$(
    find -L "''${DESKTOP_DIRS[@]}" -type f -name '*.desktop' \
      -exec awk -v max_len="$max_len" '
        BEGIN { OFS = "\t" }
        /^Name=/ && !name { name = substr($0, index($0, "=") + 1) }
        /^Exec=/ && !exec { exec = substr($0, index($0, "=") + 1) } 
        END { printf("%-*s\t%s\t%s\n", max_len, name, exec, FILENAME) }
      ' '{}' \; |
    sort -t$'\t' -k2,2 -u |
    sort -t$'\t' -k1,1 |
    ${lib.getExe fzfmenu} -d '\\t' --with-nth=1..2 |
    cut -f3
  )

  [[ -n "$entry" ]] && ${lib.getExe dex} "$entry"
''
