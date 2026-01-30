return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require("oil")
      
      -- Variable para trackear el estado del sidebar
      local oil_sidebar_open = false
      local oil_sidebar_winid = nil
      local source_winid = nil -- Ventana desde donde se abrió Oil
      
      oil.setup({
        -- Oil como explorador por defecto
        default_file_explorer = true,
        
        -- Mostrar columnas útiles para administración de servidor
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        
        -- Opciones de vista para servidor
        view_options = {
          -- Mostrar archivos ocultos por defecto (dotfiles, .env, etc.)
          show_hidden = true,
          
          -- Orden natural de archivos
          natural_order = true,
          
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        
        -- Keymaps específicos para administración
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          -- Enter: comportamiento inteligente según tipo
          ["<CR>"] = {
            callback = function()
              local entry = oil.get_cursor_entry()
              if not entry then
                return
              end
              
              -- Si es un directorio, navegar normalmente
              if entry.type == "directory" then
                oil.select()
                return
              end
              
              -- Si es un archivo y estamos en el sidebar, abrirlo en ventana principal
              local current_win = vim.api.nvim_get_current_win()
              if current_win == oil_sidebar_winid then
                -- Obtener ruta completa del archivo
                local dir = oil.get_current_dir()
                local filepath = dir .. entry.name
                
                -- Buscar ventana principal (cualquiera que no sea el sidebar de Oil)
                local target_win = source_winid
                if not target_win or not vim.api.nvim_win_is_valid(target_win) then
                  local all_wins = vim.api.nvim_list_wins()
                  for _, win in ipairs(all_wins) do
                    if win ~= oil_sidebar_winid then
                      target_win = win
                      break
                    end
                  end
                end
                
                -- Abrir archivo en ventana principal
                if target_win and vim.api.nvim_win_is_valid(target_win) then
                  vim.api.nvim_set_current_win(target_win)
                  vim.cmd("edit " .. vim.fn.fnameescape(filepath))
                  
                  -- Cerrar sidebar
                  if oil_sidebar_winid and vim.api.nvim_win_is_valid(oil_sidebar_winid) then
                    vim.api.nvim_win_close(oil_sidebar_winid, false)
                    oil_sidebar_open = false
                    oil_sidebar_winid = nil
                  end
                end
              else
                -- Si no estamos en sidebar, comportamiento normal
                oil.select()
              end
            end,
            desc = "Abrir archivo/directorio",
            mode = "n"
          },
          -- ñ también abre archivos (igual que Enter)
          ["ñ"] = {
            callback = function()
              local entry = oil.get_cursor_entry()
              if not entry then
                return
              end
              
              -- Si es un directorio, navegar normalmente
              if entry.type == "directory" then
                oil.select()
                return
              end
              
              -- Si es un archivo y estamos en el sidebar, abrirlo en ventana principal
              local current_win = vim.api.nvim_get_current_win()
              if current_win == oil_sidebar_winid then
                -- Obtener ruta completa del archivo
                local dir = oil.get_current_dir()
                local filepath = dir .. entry.name
                
                -- Buscar ventana principal (cualquiera que no sea el sidebar de Oil)
                local target_win = source_winid
                if not target_win or not vim.api.nvim_win_is_valid(target_win) then
                  local all_wins = vim.api.nvim_list_wins()
                  for _, win in ipairs(all_wins) do
                    if win ~= oil_sidebar_winid then
                      target_win = win
                      break
                    end
                  end
                end
                
                -- Abrir archivo en ventana principal
                if target_win and vim.api.nvim_win_is_valid(target_win) then
                  vim.api.nvim_set_current_win(target_win)
                  vim.cmd("edit " .. vim.fn.fnameescape(filepath))
                  
                  -- Cerrar sidebar
                  if oil_sidebar_winid and vim.api.nvim_win_is_valid(oil_sidebar_winid) then
                    vim.api.nvim_win_close(oil_sidebar_winid, false)
                    oil_sidebar_open = false
                    oil_sidebar_winid = nil
                  end
                end
              else
                -- Si no estamos en sidebar, comportamiento normal
                oil.select()
              end
            end,
            desc = "Abrir archivo/directorio (ñ)",
            mode = "n"
          },
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
          -- Atajo adicional para editar permisos rápido
          ["gp"] = {
            callback = function()
              local entry = oil.get_cursor_entry()
              if entry then
                vim.ui.input({ 
                  prompt = "Permisos (ejemplo: 755): ",
                  default = ""
                }, function(input)
                  if input then
                    local path = oil.get_current_dir() .. entry.name
                    vim.fn.system(string.format("chmod %s %s", input, vim.fn.shellescape(path)))
                    oil.discard_all_changes()
                    vim.cmd("edit")
                  end
                end)
              end
            end,
            desc = "Cambiar permisos de archivo",
            mode = "n"
          },
        },
        
        use_default_keymaps = false,
        
        -- Configuración de ventana flotante
        float = {
          padding = 2,
          max_width = 120,
          max_height = 40,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        
        -- Eliminar a la papelera (más seguro en servidor)
        delete_to_trash = true,
        
        -- Confirmar operaciones simples (más seguro)
        skip_confirm_for_simple_edits = false,
        
        -- LSP deshabilitado para mejor rendimiento
        lsp_file_methods = {
          enabled = false,
        },
      })
      
      -- Función para abrir Oil como sidebar derecho
      local function toggle_oil_sidebar()
        -- Si ya está abierto, cerrarlo
        if oil_sidebar_open and oil_sidebar_winid and vim.api.nvim_win_is_valid(oil_sidebar_winid) then
          vim.api.nvim_win_close(oil_sidebar_winid, false)
          oil_sidebar_open = false
          oil_sidebar_winid = nil
          source_winid = nil
          return
        end
        
        -- Guardar la ventana actual (desde donde se abre Oil)
        source_winid = vim.api.nvim_get_current_win()
        
        -- Ir a la ventana más a la derecha (extremo derecho de la pantalla)
        vim.cmd("wincmd l")  -- Ir lo más a la derecha posible
        vim.cmd("wincmd l")  -- Repetir para asegurar
        vim.cmd("wincmd l")
        
        -- Abrir split vertical a la derecha ABSOLUTA (botright)
        vim.cmd("botright vsplit")
        local win = vim.api.nvim_get_current_win()
        
        -- Configurar ancho del sidebar (60 columnas para ver toda la info)
        vim.api.nvim_win_set_width(win, 60)
        
        -- Abrir Oil en el directorio actual
        oil.open()
        
        -- Guardar referencias
        oil_sidebar_open = true
        oil_sidebar_winid = win
        
        -- Configurar opciones de la ventana
        vim.wo[win].number = false
        vim.wo[win].relativenumber = false
        vim.wo[win].signcolumn = "no"
        vim.wo[win].foldcolumn = "0"
        vim.wo[win].statuscolumn = ""
      end
      
      -- Keymaps globales para abrir Oil
      vim.keymap.set("n", "e", toggle_oil_sidebar, { desc = "Toggle Oil sidebar" })
      vim.keymap.set("n", "<leader>o", toggle_oil_sidebar, { desc = "Toggle Oil sidebar" })
      vim.keymap.set("n", "<leader>O", "<CMD>Oil --float<CR>", { desc = "Abrir Oil flotante" })
      vim.keymap.set("n", "-", function()
        oil.open()
      end, { desc = "Abrir Oil en directorio padre" })
    end
  }
}
