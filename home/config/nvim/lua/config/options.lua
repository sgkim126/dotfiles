vim.cmd("colorscheme vim")
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#FFFFFF", bg = "#1A1B26" })

-- Git commit message rules
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    -- Enable spell check
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"

    -- Set global color at 72 characters
    vim.opt_local.colorcolumn = "73"

    -- Define highlight links
    vim.cmd([[
      highlight link GitCommitSummaryLong Debug
      highlight link GitCommitSummaryOverflow Error
      highlight link GitCommitSummaryLastDot Error
      highlight link GitCommitBodyOverflow Error
    ]])

    -- Summary (Line 1) > 50 chars
    vim.fn.matchadd("GitCommitSummaryLong", [[\%1l\%>50v.*]], 10)
    -- Summary (Line 1) > 72 chars
    vim.fn.matchadd("GitCommitSummaryOverflow", [[\%1l\%>72v.*]], 11)
    -- Summary (Line 1) ends with a dot
    vim.fn.matchadd("GitCommitSummaryLastDot", [[\%1l\.$]], 12)
    -- Body (Lines > 2) > 72 chars (ignoring comments)
    vim.fn.matchadd("GitCommitBodyOverflow", [[\%>2l\%(^#\)\@!\%>72v.*]], 10)
  end,
})
