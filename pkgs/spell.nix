{
  writeShellScriptBin,
  lib,
  hunspell,
  hunspellDicts,
}:
writeShellScriptBin "spell" ''
  export DICPATH="${hunspellDicts.en_US}/share/hunspell"
  echo $1 | ${lib.getExe hunspell} -a | sed -n '2s/.*: //p' | sed 's/, /\n/g'
''
