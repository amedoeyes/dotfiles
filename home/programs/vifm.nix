{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.vifm;
in
{
  config = lib.mkIf cfg.enable {
    programs.zsh.initContent = (
      lib.mkOrder 900 ''
        function vifm {
        	cd "$(command ${lib.getExe pkgs.vifm} --choose-dir - $@)"
        }
      ''
    );

    xdg.configFile."vifm/colors/eyes.vifm".text = ''
      highlight clear
      highlight Win          ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight AuxWin       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight OtherWin     ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight Border       ctermfg=${config.theme.colors.ansi04} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex04} guibg=${config.theme.colors.hex00} gui=none
      highlight TabLine      ctermfg=${config.theme.colors.ansi06} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex06} guibg=${config.theme.colors.hex00} gui=none
      highlight TabLineSel   ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=bold guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=bold
      highlight TopLine      ctermfg=${config.theme.colors.ansi06} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex06} guibg=${config.theme.colors.hex00} gui=none
      highlight TopLineSel   ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=bold guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=bold
      highlight CmdLine      ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight ErrorMsg     ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight StatusLine   ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight JobLine      ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight WildBox      ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight WildMenu     ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi01} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex01} gui=none
      highlight SuggestBox   ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight CurrLine     ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi01} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex01} gui=none
      highlight OtherLine    ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight OddLine      ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight LineNr       ctermfg=${config.theme.colors.ansi04} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex04} guibg=${config.theme.colors.hex00} gui=none
      highlight Selected     ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi02} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex02} gui=none
      highlight Directory    ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight Link         ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight BrokenLink   ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight HardLink     ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight Socket       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight Device       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight Executable   ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight Fifo         ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight CmpMismatch  ctermfg=${config.theme.colors.ansi06} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex06} guibg=${config.theme.colors.hex00} gui=none
      highlight CmpUnmatched ctermfg=${config.theme.colors.ansi06} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex06} guibg=${config.theme.colors.hex00} gui=none
      highlight CmpBlank     ctermfg=${config.theme.colors.ansi04} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex04} guibg=${config.theme.colors.hex00} gui=none
      highlight User1        ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User2        ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User3        ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User4        ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User5        ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User6        ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User7        ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User8        ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User9        ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User10       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User11       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User12       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User13       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User14       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User15       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User16       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User17       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User18       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User19       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
      highlight User20       ctermfg=${config.theme.colors.ansi10} ctermbg=${config.theme.colors.ansi00} cterm=none guifg=${config.theme.colors.hex10} guibg=${config.theme.colors.hex00} gui=none
    '';

    programs.vifm = {
      extraConfig =
        let
          options = ''
            let &vicmd = $EDITOR

            set confirm=permdelete
            set dotdirs=""
            set dotfiles
            set fillchars=vborder:"│",hborder:"─",millersep:"│"
            set history=100
            set ignorecase
            set incsearch
            set mouse="a"
            set nofollowlinks
            set nohlsearch
            set nols
            set nowrap
            set scrolloff=4
            set sizefmt=units:iec,precision:2,nospace
            set smartcase
            set sortnumbers
            set suggestoptions=normal,visual,view,otherpane,keys,marks,registers
            set syscalls
            set tablabel="%t "
            set tabprefix=""
            set tabsuffix=""
            set timefmt="%Y-%m-%d %H:%M"
            set trashdir="%r/$XDG_DATA_HOME/Trash/"
            set tuioptions=puv
            set undolevels=100
            set vifminfo=dhistory,chistory,state,tabs,shistory,ehistory,phistory,fhistory,dirstack,registers,bookmarks,bmarks,mchistory
            set vimhelp
            set wildmenu
            set wildstyle=popup

            view
            if &columns < 80
            	only
            endif

            colorscheme eyes
          '';

          marks = ''
            mark t /tmp/
            mark n /etc/nixos/
            mark h ~/
            mark c ~/.config/
            mark l ~/.local/
          '';

          keybinds = ''
            nnoremap K <C-g>
            nnoremap s :sort<cr>
            nnoremap w :vsplit | view<cr>
            nnoremap yd :!echo -n %d | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} %i && echo -n %d | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} -p %i<cr>
            nnoremap yf :!echo -n %c:p | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} %i && echo -n %c:p | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} -p %i<cr>
            nnoremap q :quit<cr>
          '';

          filetype = ''
            filetype * ${lib.getExe' pkgs.xdg-utils "xdg-open"} &
          '';

          fileviewer =
            with pkgs;
            with lib;
            ''
              fileviewer */,.*/ ${getExe tree} -L1 -a --noreport %c

              fileviewer *.tar ${getExe gnutar} -tf %c
              fileviewer *.tar.bz2,*.tbz2 ${getExe gnutar} -tjf %c
              fileviewer *.tar.xz,*.txz ${getExe gnutar} -tJf %c
              fileviewer *.tar.zst,*.tzst ${getExe gnutar} -t --zstd -f %c
              fileviewer *.tgz,*.tar.gz ${getExe gnutar} -tzf %c
              fileviewer *.zip,*.jar,*.war,*.ear,*.oxt ${getExe unzip} -l %f
              fileviewer *.7z ${getExe p7zip} l %c

              fileviewer <application/pdf> ${getExe' poppler-utils "pdftoppm"} -singlefile -png %c 2>/dev/null | ${getExe chafa} --relative on -s %pwx%ph %pd %N
              fileviewer <application/octet-stream>,<application/x-executable> ${getExe file} %c

              fileviewer <application/*> ${getExe' coreutils "cat"} %c
              fileviewer <audio/*> ${getExe' ffmpeg "ffprobe"} -hide_banner -pretty %c 2>&1
              fileviewer <image/*> ${getExe chafa} --relative on --animate off -s %pwx%ph %c %pd %N
              fileviewer <text/*> ${getExe' coreutils "cat"} %c
              fileviewer <video/*> ${getExe ffmpeg} -loglevel quiet -i %c -frames:v 1 -ss 0.1 -f image2pipe -vcodec png - | ${getExe chafa} --relative on -s %pwx%ph %pd %N

              fileviewer * ${getExe file} %c
            '';

          icons = ''
            set classify=""
            set classify+=" :link:"
            set classify+=" :block:"
            set classify+=" :char:"
            set classify+="󰉋 :dir:"
            set classify+=" :exe:"
            set classify+=" :fifo:"
            set classify+="󰈔 :reg:"
            set classify+=" :sock:"

            set classify+="󰪺 ::.cache/::"
            set classify+="󱁿 ::.config/::"
            set classify+=" ::.git/,,.dotfiles/::"
            set classify+=" ::.github/::"
            set classify+="󰉌 ::.local/::"
            set classify+="󰚝 ::Desktop/::"
            set classify+="󱧼 ::Development/::"
            set classify+="󱧶 ::Documents/::"
            set classify+="󰉍 ::Downloads/::"
            set classify+="󱞊 ::Movies/,,Videos/::"
            set classify+="󱍙 ::Music/::"
            set classify+="󰣞 ::Notebook/,,Notes/::"
            set classify+="󰉏 ::Pictures/,,Media/::"
            set classify+="󱧰 ::Public/::"
            set classify+="󱋣 ::Template/::"
            set classify+="󱧴 ::Trash/::"
            set classify+="󱧺 ::bin/::"
            set classify+="󱧼 ::build/::"
            set classify+="󰴋 ::boot/::"
            set classify+="󱂷 ::doc/::"
            set classify+="󱂷 ::docs/::"
            set classify+="󱁿 ::etc/::"
            set classify+="󱂵 ::home/::"
            set classify+="󰲂 ::lib/::"
            set classify+="󰉓 ::mnt/::"
            set classify+="󰉗 ::opt/::"
            set classify+="󰢬 ::proc/::"
            set classify+="󱧺 ::sbin/::"
            set classify+="󰴉 ::src/::"
            set classify+="󱋣 ::srv/::"
            set classify+="󰪺 ::tmp/::"
            set classify+="󱞊 ::test/::"
            set classify+="󱞊 ::tests/::"
            set classify+="󰉌 ::usr/::"
            set classify+="󱋣 ::var/::"

            set classify+="󰣇 ::.SRCINFO::"
            set classify+=" ::.Xauthority,,.Xresources,,.xinitrc,,.xsession,,xorg.conf,,xsettingsd.conf::"
            set classify+=" ::.babelrc::"
            set classify+=" ::.bash_profile,,.bashrc,,.ds_store,,.gitconfig,,.luaurc,,.zprofile,,.zshenv,,.zshrc,,cmakelists.txt,,config::"
            set classify+="󰡨 ::.dockerignore,,compose.yaml,,compose.yml,,containerfile,,docker-compose.yaml,,docker-compose.yml,,dockerfile::"
            set classify+=" ::.editorconfig::"
            set classify+=" ::.env::"
            set classify+=" ::.eslintignore,,.eslintrc,,eslint.config.cjs,,eslint.config.js,,eslint.config.mjs,,eslint.config.ts::"
            set classify+=" ::.git-blame-ignore-revs,,.gitattributes,,.gitignore,,.gitmodules,,commit_editmsg::"
            set classify+=" ::.gitlab-ci.yml::"
            set classify+=" ::.gtkrc-2.0,,gtkrc::"
            set classify+=" ::.gvimrc,,.vimrc,,_gvimrc,,_vimrc::"
            set classify+=" ::.justfile,,justfile::"
            set classify+="󰊢 ::.mailmap::"
            set classify+=" ::.npmignore,,.npmrc,,package-lock.json,,package.json::"
            set classify+="󱄆 ::.nuxtrc,,nuxt.config.cjs,,nuxt.config.js,,nuxt.config.mjs,,nuxt.config.ts::"
            set classify+=" ::.nvmrc,,node_modules::"
            set classify+=" ::.prettierignore,,.prettierrc,,.prettierrc.cjs,,.prettierrc.js,,.prettierrc.json,,.prettierrc.json5,,.prettierrc.mjs,,.prettierrc.toml,,.prettierrc.yaml,,.prettierrc.yml,,prettier.config.cjs,,prettier.config.js,,prettier.config.mjs,,prettier.config.ts::"
            set classify+=" ::.settings.json::"
            set classify+=" ::FreeCAD.conf::"
            set classify+=" ::PKGBUILD::"
            set classify+=" ::PrusaSlicer.ini,,PrusaSlicerGcodeViewer.ini::"
            set classify+=" ::QtProject.conf::"
            set classify+=" ::avif::"
            set classify+=" ::brewfile,,gemfile$,,rakefile::"
            set classify+=" ::bspwmrc,,sxhkdrc::"
            set classify+=" ::build,,workspace::"
            set classify+=" ::build.gradle,,gradle-wrapper.properties,,gradle.properties,,gradlew,,settings.gradle::"
            set classify+=" ::build.zig.zon::"
            set classify+=" ::cantorrc,,kalgebrarc,,kdeglobals::"
            set classify+="󰓙 ::checkhealth::"
            set classify+=" ::code_of_conduct,,code_of_conduct.md::"
            set classify+="󰜘 ::commitlint.config.js,,commitlint.config.ts::"
            set classify+=" ::copying,,copying.lesser,,license,,license.md,,unlicense::"
            set classify+=" ::ext_typoscript_setup.txt::"
            set classify+=" ::favicon.ico::"
            set classify+=" ::fp-info-cache,,fp-lib-table,,sym-lib-table::"
            set classify+=" ::gnumakefile,,makefile::"
            set classify+=" ::go.mod,,go.sum,,go.work::"
            set classify+=" ::groovy::"
            set classify+=" ::gruntfile.babel.js,,gruntfile.coffee,,gruntfile.js,,gruntfile.ts::"
            set classify+=" ::gulpfile.babel.js,,gulpfile.coffee,,gulpfile.js,,gulpfile.ts::"
            set classify+=" ::hypridle.conf,,hyprland.conf,,hyprlock.conf,,hyprpaper.conf::"
            set classify+="󰗊 ::i18n.config.js,,i18n.config.ts::"
            set classify+=" ::i3blocks.conf,,i3status.conf::"
            set classify+=" ::ionic.config.json::"
            set classify+=" ::kdenlive-layoutsrc,,kdenliverc::"
            set classify+=" ::kritadisplayrc,,kritarc::"
            set classify+=" ::lxde-rc.xml::"
            set classify+=" ::lxqt.conf::"
            set classify+=" ::mix.lock::"
            set classify+=" ::mpv.conf::"
            set classify+=" ::platformio.ini::"
            set classify+=" ::pom.xml::"
            set classify+=" ::procfile::"
            set classify+=" ::py.typed::"
            set classify+=" ::rmd::"
            set classify+="󰚩 ::robots.txt::"
            set classify+="󰒃 ::security,,security.md::"
            set classify+=" ::svelte.config.js::"
            set classify+="󰾴 ::swapfile::"
            set classify+="󱏿 ::tailwind.config.js,,tailwind.config.mjs,,tailwind.config.ts::"
            set classify+=" ::tmux.conf,,tmux.conf.local::"
            set classify+=" ::tsconfig.json::"
            set classify+=" ::vagrantfile$::"
            set classify+="▲ ::vercel.json::"
            set classify+="󰕼 ::vlcrc::"
            set classify+="󰜫 ::webpack::"
            set classify+=" ::weston.ini::"
            set classify+=" ::xmobarrc,,xmobarrc.hs,,xmonad.hs::"

            set classify+="󰈫 ::*.3gp,,*.cast,,*.m4v,,*.mkv,,*.mov,,*.mp4,,*.webm::"
            set classify+="󰆧 ::*.3mf,,*.fbx,,*.obj,,*.ply,,*.stl,,*.wrl,,*.wrz::"
            set classify+=" ::*.7z,,*.bz,,*.bz2,,*.bz3,,*.gz,,*.rar,,*.tgz,,*.txz,,*.xz,,*.zip,,*.zst::"
            set classify+="󰡨 ::*.Dockerfile::"
            set classify+="󰟔 ::*.R,,*.r::"
            set classify+=" ::*.a,,*.dll,,*.lib,,*.so::"
            set classify+="󰈣 ::*.aac,,*.aif,,*.aiff,,*.ape,,*.flac,,*.m4a,,*.mp3,,*.ogg,,*.opus,,*.pcm,,*.wav,,*.wma,,*.wv,,*.wvc::"
            set classify+=" ::*.ai::"
            set classify+=" ::*.android,,*.apk::"
            set classify+="⍝ ::*.apl::"
            set classify+=" ::*.app,,*.bin,,*.elf,,*.exe,,*.o,,*.out::"
            set classify+=" ::*.applescript::"
            set classify+="󰦝 ::*.asc::"
            set classify+="󰨖 ::*.ass,,*.lrc,,*.srt,,*.ssa,,*.sub::"
            set classify+=" ::*.astro::"
            set classify+=" ::*.awk,,*.bash,,*.csh,,*.fish,,*.ksh,,*.sh,,*.zsh::"
            set classify+=" ::*.azcli::"
            set classify+="󰁯 ::*.bak::"
            set classify+=" ::*.bat,,*.cfg,,*.cmake,,*.conf,,*.ini,,*.yaml,,*.yml::"
            set classify+=" ::*.bazel,,*.bzl::"
            set classify+="󱉟 ::*.bib::"
            set classify+=" ::*.bicep,,*.bicepparam::"
            set classify+=" ::*.blade.php::"
            set classify+="󰂫 ::*.blend::"
            set classify+="󰺾 ::*.blp::"
            set classify+="󰈟 ::*.bmp,,*.gif,,*.ico,,*.jpeg,,*.jpg,,*.jxl,,*.png,,*.webp::"
            set classify+="⎉ ::*.bqn::"
            set classify+="󰻫 ::*.brep,,*.dwg,,*.dxf,,*.f3d,,*.ifc,,*.ige,,*.iges,,*.igs,,*.skp,,*.sldasm,,*.sldprt,,*.slvs,,*.ste,,*.step,,*.stp::"
            set classify+=" ::*.c,,*.m::"
            set classify+=" ::*.c++,,*.cc,,*.ccm,,*.cp,,*.cpp,,*.cppm,,*.cxx,,*.cxxm,,*.ixx,,*.mm,,*.mpp::"
            set classify+=" ::*.cache::"
            set classify+="⚙ ::*.cbl,,*.cob,,*.cobol,,*.cpy::"
            set classify+=" ::*.cjs,,*.js,,*.mjs::"
            set classify+=" ::*.clj,,*.cljc::"
            set classify+=" ::*.cljd,,*.cljs,,*.edn::"
            set classify+=" ::*.coffee::"
            set classify+=" ::*.config.ru,,*.gemspec,,*.rake,,*.rb::"
            set classify+="󰆚 ::*.cow::"
            set classify+=" ::*.cr::"
            set classify+=" ::*.crdownload,,*.download,,*.fdmdownload,,*.part,,*.torrent::"
            set classify+="󰌛 ::*.cs::"
            set classify+="󱦗 ::*.cshtml::"
            set classify+=" ::*.cson,,*.json,,*.json5,,*.jsonc,,*.nswag,,*.webmanifest::"
            set classify+="󰪮 ::*.csproj::"
            set classify+=" ::*.css::"
            set classify+=" ::*.csv::"
            set classify+=" ::*.cts,,*.d.ts,,*.mts,,*.ts::"
            set classify+=" ::*.cu,,*.cuh::"
            set classify+="󰲹 ::*.cue,,*.m3u,,*.m3u8,,*.pls::"
            set classify+=" ::*.d::"
            set classify+=" ::*.dart::"
            set classify+=" ::*.db,,*.dump,,*.sql,,*.sqlite,,*.sqlite3::"
            set classify+=" ::*.dconf::"
            set classify+=" ::*.desktop::"
            set classify+=" ::*.diff,,*.patch::"
            set classify+="󰈬 ::*.doc,,*.docx::"
            set classify+="󱁉 ::*.dot,,*.gv::"
            set classify+=" ::*.drl::"
            set classify+=" ::*.dropbox::"
            set classify+=" ::*.ebook,,*.epub,,*.mobi::"
            set classify+=" ::*.ebuild::"
            set classify+=" ::*.eex,,*.ex,,*.exs,,*.heex,,*.leex::"
            set classify+=" ::*.ejs,,*.erb,,*.haml,,*.htm,,*.slim::"
            set classify+=" ::*.el,,*.elc,,*.eln::"
            set classify+=" ::*.elm::"
            set classify+=" ::*.env::"
            set classify+=" ::*.eot,,*.flc,,*.flf,,*.lff,,*.otf,,*.ttf,,*.woff,,*.woff2::"
            set classify+=" ::*.epp,,*.pp::"
            set classify+=" ::*.erl,,*.hrl::"
            set classify+=" ::*.f#,,*.fs,,*.fsi,,*.fsscript,,*.fsx::"
            set classify+="󱈚 ::*.f90::"
            set classify+=" ::*.fcbak,,*.fcmacro,,*.fcmat,,*.fcparam,,*.fcscript,,*.fcstd,,*.fcstd1,,*.fctb,,*.fctl::"
            set classify+=" ::*.fnl::"
            set classify+="󰐫 ::*.gcode::"
            set classify+=" ::*.gd,,*.godot,,*.tres,,*.tscn::"
            set classify+=" ::*.git::"
            set classify+=" ::*.glb::"
            set classify+=" ::*.gleam::"
            set classify+=" ::*.gnumakefile,,*.makefile,,*.mk::"
            set classify+=" ::*.go::"
            set classify+=" ::*.gql,,*.graphql::"
            set classify+=" ::*.gradle::"
            set classify+=" ::*.gresource::"
            set classify+=" ::*.h,,*.hh,,*.hpp,,*.hxx::"
            set classify+=" ::*.hbs,,*.mustache::"
            set classify+=" ::*.hex::"
            set classify+=" ::*.hs,,*.lhs::"
            set classify+=" ::*.html::"
            set classify+=" ::*.http::"
            set classify+="󰡘 ::*.huff::"
            set classify+=" ::*.hurl::"
            set classify+=" ::*.hx::"
            set classify+=" ::*.ical,,*.icalendar,,*.ics,,*.ifb::"
            set classify+=" ::*.image,,*.img,,*.iso::"
            set classify+=" ::*.import::"
            set classify+=" ::*.info,,*.nfo::"
            set classify+=" ::*.ino::"
            set classify+=" ::*.ipynb,,*.pxd,,*.pxi,,*.py,,*.pyc,,*.pyd,,*.pyi,,*.pyo,,*.pyw,,*.pyx::"
            set classify+=" ::*.java::"
            set classify+=" ::*.jl::"
            set classify+=" ::*.jsx::"
            set classify+=" ::*.jwmrc::"
            set classify+="󰯄 ::*.kbx::"
            set classify+=" ::*.kdb,,*.kdbx::"
            set classify+=" ::*.kdenlive,,*.kdenlivetitle::"
            set classify+=" ::*.kicad_dru,,*.kicad_mod,,*.kicad_pcb,,*.kicad_prl,,*.kicad_pro,,*.kicad_sch,,*.kicad_sym,,*.kicad_wks::"
            set classify+=" ::*.ko::"
            set classify+=" ::*.kpp,,*.kra,,*.krz::"
            set classify+=" ::*.kt,,*.kts::"
            set classify+=" ::*.lck,,*.lock::"
            set classify+=" ::*.less::"
            set classify+=" ::*.license::"
            set classify+=" ::*.liquid::"
            set classify+="󰌱 ::*.log::"
            set classify+=" ::*.lua,,*.luac,,*.luau::"
            set classify+=" ::*.magnet::"
            set classify+=" ::*.markdown,,*.rmd::"
            set classify+="󰔉 ::*.material::"
            set classify+=" ::*.md,,*.mdx::"
            set classify+="󰕥 ::*.md5,,*.sha1,,*.sha224,,*.sha256,,*.sha384,,*.sha512::"
            set classify+="󰌪 ::*.mint::"
            set classify+=" ::*.ml,,*.mli::"
            set classify+="∞ ::*.mo::"
            set classify+=" ::*.mojo,,*.🔥::"
            set classify+=" ::*.msf::"
            set classify+=" ::*.nim::"
            set classify+=" ::*.nix::"
            set classify+="> ::*.nu::"
            set classify+=" ::*.org::"
            set classify+=" ::*.pck::"
            set classify+=" ::*.pdf::"
            set classify+=" ::*.php::"
            set classify+=" ::*.pl,,*.pm,,*.t::"
            set classify+=" ::*.po,,*.pot,,*.qm,,*.strings,,*.xcstrings::"
            set classify+="󰈧 ::*.ppt::"
            set classify+=" ::*.prisma::"
            set classify+=" ::*.pro::"
            set classify+="󰨊 ::*.ps1,,*.psd1,,*.psm1::"
            set classify+=" ::*.psb,,*.psd::"
            set classify+="󰷖 ::*.pub::"
            set classify+=" ::*.qml,,*.qrc,,*.qss::"
            set classify+=" ::*.query::"
            set classify+="󱦘 ::*.razor::"
            set classify+=" ::*.res,,*.resi::"
            set classify+=" ::*.rlib::"
            set classify+="󰗆 ::*.rproj::"
            set classify+=" ::*.rs::"
            set classify+=" ::*.rss::"
            set classify+=" ::*.sass,,*.scss::"
            set classify+=" ::*.sbt,,*.sc,,*.scala::"
            set classify+=" ::*.scad::"
            set classify+="󰘧 ::*.scm::"
            set classify+="λ ::*.sig,,*.signature,,*.sml::"
            set classify+=" ::*.sln,,*.suo,,*.vsix::"
            set classify+=" ::*.sol::"
            set classify+=" ::*.spec.js,,*.spec.jsx,,*.spec.ts,,*.spec.tsx,,*.test.js,,*.test.jsx,,*.test.ts,,*.test.tsx::"
            set classify+=" ::*.styl::"
            set classify+=" ::*.sublime::"
            set classify+="󰍛 ::*.sv,,*.svh,,*.v,,*.vh,,*.vhd,,*.vhdl::"
            set classify+=" ::*.svelte::"
            set classify+="󰜡 ::*.svg::"
            set classify+=" ::*.swift,,*.xcplayground::"
            set classify+="󰛓 ::*.tbc,,*.tcl::"
            set classify+=" ::*.templ::"
            set classify+=" ::*.terminal::"
            set classify+=" ::*.tex::"
            set classify+=" ::*.tf::"
            set classify+=" ::*.tfvars::"
            set classify+=" ::*.tmux::"
            set classify+=" ::*.toml::"
            set classify+=" ::*.tsconfig,,*.typoscript::"
            set classify+=" ::*.tsx::"
            set classify+=" ::*.twig::"
            set classify+="󰈙 ::*.txt::"
            set classify+=" ::*.ui::"
            set classify+=" ::*.vala::"
            set classify+=" ::*.vim::"
            set classify+=" ::*.vsh::"
            set classify+=" ::*.vue::"
            set classify+=" ::*.wasm::"
            set classify+="󰜫 ::*.webpack::"
            set classify+=" ::*.x,,*.xm::"
            set classify+="󰙳 ::*.xaml::"
            set classify+=" ::*.xcf::"
            set classify+="󰈛 ::*.xls,,*.xlsx::"
            set classify+="󰗀 ::*.xml::"
            set classify+=" ::*.xpi::"
            set classify+=" ::*.xul::"
            set classify+=" ::*.zig::"
          '';
        in
        lib.mkMerge [
          options
          marks
          keybinds
          filetype
          fileviewer
          icons
        ];
    };
  };
}
