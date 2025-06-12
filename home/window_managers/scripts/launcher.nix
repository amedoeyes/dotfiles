{
  writeShellScriptBin,
  lib,
  coreutils,
  gawk,
  findutils,
  fzfmenu,
  dex,
}:
let
  sortBin = lib.getExe' coreutils "sort";
  headBin = lib.getExe' coreutils "head";
  findBin = lib.getExe findutils;
  cutBin = lib.getExe' coreutils "cut";
  awkBin = lib.getExe gawk;
  fzfmenuBin = lib.getExe fzfmenu;
  dexBin = lib.getExe dex;
in
writeShellScriptBin "launcher" ''
  DESKTOP_DIRS=()
  IFS=':' read -ra DIRS <<< "$XDG_DATA_DIRS"
  for dir in "''${DIRS[@]}"; do
    DESKTOP_DIRS+=("$dir/applications")
  done

  max_len=$(
    ${findBin} -L "''${DESKTOP_DIRS[@]}" -type f -name '*.desktop' \
      -exec ${awkBin} '
        /^Name=/ {
          name = substr($0, index($0, "=") + 1)
          print(length(name))
        }
      ' '{}' \; |
    ${sortBin} -nr |
    ${headBin} -1
  )

  entry=$(
    ${findBin} -L "''${DESKTOP_DIRS[@]}" -type f -name '*.desktop' \
      -exec ${awkBin} -v max_len="$max_len" '
        BEGIN { OFS = "\t" }
        /^Name=/ && !name { name = substr($0, index($0, "=") + 1) }
        /^Exec=/ && !exec { exec = substr($0, index($0, "=") + 1) } 
        END { printf("%-*s\t%s\t%s\n", max_len, name, exec, FILENAME) }
      ' '{}' \; |
    ${sortBin} -t$'\t' -k2,2 -u |
    ${sortBin} -t$'\t' -k1,1 |
    ${fzfmenuBin} -d '\\t' --with-nth=1..2 |
    ${cutBin} -f3
  )

  [[ -n "$entry" ]] && ${dexBin} "$entry"
''
