local platform = require('utils.platform')

local options = {
   -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
   -- ssh_domains = {},
   ssh_domains = {},

   -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
   unix_domains = {},

   -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
   wsl_domains = {},
}

if not platform.is_win then
   options.ssh_domains =
   {
      -- yazi's image preview on Windows will only work if launched via ssh from WSL
      {
         name = 'ssh',
         remote_address = 'localhost',
         multiplexing = 'None',
         default_prog = { 'bash', '-l' },
         assume_shell = 'Posix'
      }
   }
end

return options
