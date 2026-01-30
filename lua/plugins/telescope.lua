return {
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = { 
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      
      telescope.setup({
        defaults = {
          -- Ignorar archivos binarios y pesados
          file_ignore_patterns = {
            "%.jar$",
            "%.war$",
            "%.class$",
            "%.so$",
            "%.o$",
            "%.a$",
            "%.dll$",
            "%.exe$",
            "%.bin$",
            "%.iso$",
            "%.img$",
            "%.zip$",
            "%.tar",
            "%.gz$",
            "%.bz2$",
            "%.xz$",
            "%.7z$",
            "%.rar$",
            "%.pdf$",
            "%.mp4$",
            "%.mkv$",
            "%.avi$",
            "%.jpg$",
            "%.jpeg$",
            "%.png$",
            "%.gif$",
            "node_modules/",
            ".git/",
            "target/",
            "build/",
          },
          
          -- Respetar archivos ocultos
          hidden = true,
          
          -- Layout optimizado
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              width = 0.95,
              height = 0.95,
            },
          },
          
          -- Mapeos útiles
          mappings = {
            i = {
              ["<C-h>"] = "which_key",
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
          
          -- Seguir enlaces simbólicos
          follow = true,
        },
        
        pickers = {
          find_files = {
            -- Incluir archivos ocultos
            hidden = true,
            -- No respetar .gitignore
            no_ignore = true,
            -- Seguir symlinks
            follow = true,
          },
          live_grep = {
            -- Buscar en archivos ocultos
            additional_args = function()
              return { "--hidden", "--no-ignore" }
            end,
          },
        },
      })
      
      -- Buscadores personalizados para administración de servidor Bare Metal
      
      -- Buscar en /etc/
      vim.keymap.set('n', '<leader>fe', function()
        builtin.find_files({
          prompt_title = "Archivos de Configuración (/etc/)",
          cwd = "/etc",
          hidden = true,
          no_ignore = true,
          follow = true,
        })
      end, { desc = "Buscar en /etc/" })
      
      -- Buscar en /etc/systemd/system/
      vim.keymap.set('n', '<leader>fS', function()
        builtin.find_files({
          prompt_title = "Servicios Systemd (/etc/systemd/system/)",
          cwd = "/etc/systemd/system",
          hidden = true,
          no_ignore = true,
          follow = true,
        })
      end, { desc = "Buscar en /etc/systemd/system/" })
      
      -- Buscar archivos de log
      vim.keymap.set('n', '<leader>fl', function()
        builtin.find_files({
          prompt_title = "Archivos de Log",
          find_command = { "fd", "-t", "f", "-e", "log", "-H", "--no-ignore" },
        })
      end, { desc = "Buscar archivos .log" })
      
      -- Buscar en /var/log/
      vim.keymap.set('n', '<leader>fL', function()
        builtin.find_files({
          prompt_title = "Logs del Sistema (/var/log/)",
          cwd = "/var/log",
          hidden = true,
          no_ignore = true,
          follow = true,
        })
      end, { desc = "Buscar en /var/log/" })
      
      -- Buscar configuraciones comunes del servidor
      vim.keymap.set('n', '<leader>fc', function()
        builtin.find_files({
          prompt_title = "Configuraciones del Servidor",
          find_command = {
            "fd", "-t", "f",
            "-e", "conf", "-e", "config", "-e", "cfg",
            "-e", "yaml", "-e", "yml", "-e", "json",
            "-e", "toml", "-e", "ini",
            "-H", "--no-ignore",
          },
        })
      end, { desc = "Buscar archivos de configuración" })
      
      -- Buscar en directorio actual (con opciones de servidor)
      -- ATAJO PRINCIPAL: <leader><leader> (doble espacio)
      vim.keymap.set('n', '<leader><leader>', function()
        builtin.find_files({
          hidden = true,
          no_ignore = true,
          follow = true,
        })
      end, { desc = "Buscar archivos (doble espacio)" })
      
      -- Atajo alternativo
      vim.keymap.set('n', '<leader>ff', function()
        builtin.find_files({
          hidden = true,
          no_ignore = true,
          follow = true,
        })
      end, { desc = "Buscar archivos" })
      
      -- Grep en directorio actual (sin respetar .gitignore)
      vim.keymap.set('n', '<leader>fg', function()
        builtin.live_grep({
          additional_args = function()
            return { "--hidden", "--no-ignore" }
          end,
        })
      end, { desc = "Grep en archivos" })
      
      -- Buffers
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buscar buffers" })
      
      -- Ayuda
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Buscar ayuda" })
    end
  }
}
