return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",           -- LSP 서버 설치 관리자
      "williamboman/mason-lspconfig.nvim", -- mason과 lspconfig 연결
    },
    config = function()
      local status_mason, mason = pcall(require, "mason")
      local status_mlsp, mlsp = pcall(require, "mason-lspconfig")
      local status_lspconfig, lspconfig = pcall(require, "lspconfig")

      if not status_mason or not status_mlsp or not status_lspconfig then
        return
      end

      mason.setup()
      mlsp.setup({
        -- lspconfig에서 설정된 서버가 설치되어 있지 않으면 자동으로 설치
        automatic_installation = true,
      })

      -- 이미 설치된 서버들은 즉시 활성화
      local function setup_server(server)
        if vim.lsp.config then -- Neovim 0.11+
          vim.lsp.enable(server)
        else
          lspconfig[server].setup({})
        end
      end

      for _, server in ipairs(mlsp.get_installed_servers()) do
        setup_server(server)
      end

      -- 파일 타입별 권장 LSP 서버 매핑
      local ft_to_server = {
        lua = "lua_ls",
        python = "pyright",
        rust = "rust_analyzer",
        cpp = "clangd",
        c = "clangd",
        go = "gopls",
        javascript = "ts_ls",
        typescript = "ts_ls",
        javascriptreact = "ts_ls",
        typescriptreact = "ts_ls",
        sh = "bashls",
      }

      -- 파일을 열 때 해당 타입의 LSP가 없으면 자동으로 설치
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local server = ft_to_server[vim.bo[args.buf].filetype]
          if server and not (vim.lsp.get_clients({ name = server })[1]) then
            setup_server(server)
          end
        end,
      })

      -- LSP 단축키 설정 (LSP가 파일에 연결될 때 자동으로 적용됨)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }

          -- ctags 스타일 탐색 (Ctrl-] 정의 이동 / Ctrl-t 복귀)
          vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"

          vim.keymap.set('n', '<leader>K',  vim.lsp.buf.hover, opts) -- 정보 확인

          vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)      -- 정의 이동
          vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)     -- 선언 이동
          vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)      -- 참조 확인
          vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)  -- 구현 이동
          vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts) -- 타입 정의 이동

          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- 이름 변경(Rename)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- 코드 액션
          vim.keymap.set('n', '<leader>f', function() -- 코드 포맷팅
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  },
}
