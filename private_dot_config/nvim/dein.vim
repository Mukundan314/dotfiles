function! s:SourcePluginConfig() abort
  let l:config_file = s:plugin_config_dir . '/' . g:dein#plugin.normalized_name . '.vim'

  if filereadable(l:config_file)
    execute 'source' l:config_file
  endif
endfunction


let s:plugin_dir = stdpath('cache') . '/dein'
let s:dein_dir = s:plugin_dir . '/repos/github.com/Shougo/dein.vim'
let s:plugin_config_dir = stdpath('config') . '/plugin_config'

let s:dein_toml = stdpath('config') . '/dein.toml'
let s:dein_lazy_toml = stdpath('config') . '/deinlazy.toml'

if empty(glob(s:dein_dir))
  echomsg 'Installing dein...'
  execute 'silent !git clone https://github.com/Shougo/dein.vim' s:dein_dir
endif

execute 'set runtimepath+=' . s:dein_dir

if dein#load_state(s:plugin_dir)
  call dein#begin(s:plugin_dir, [expand('<sfile>'), s:dein_toml, s:dein_lazy_toml])

  call dein#load_toml(s:dein_toml, {'lazy': 0})
  call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

call dein#set_hook([], 'hook_source', function('s:SourcePluginConfig'))
call dein#call_hook('source')
