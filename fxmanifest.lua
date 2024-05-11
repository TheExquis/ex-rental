fx_version 'cerulean'

games {"gta5"}

author "Tony"
version '1.0.0'

lua54 'yes'

ui_page 'web/build/index.html'

shared_scripts {
  -- '@es_extended/imports.lua',
  '@ox_lib/init.lua',
  "shared/*.lua"
}

client_script "client/**/*"

server_scripts {
  "bridge/**/server.lua",
  "server/**/*"
}

files {
  'web/build/index.html',
  'web/build/**/*'
}
