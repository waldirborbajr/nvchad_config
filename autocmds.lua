    local function augroup(name) return vim.api.nvim_create_augroup("lit_" .. name, { clear = true }) end

    -- Disable continuation comment on next line
    vim.api.nvim_create_autocmd("User", {
      desc = "no auto comment after pressing o",
      pattern = "*",
      command = "setlocal formatoptions-=cro",
    })

    -- Remember cursor position when reopening files go to last loc when opening a buffer
    vim.api.nvim_create_autocmd("BufReadPost", {
      group = augroup "last_loc",
      callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then return end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
      end,
    })

    -- Open Github repository
    vim.api.nvim_create_user_command("OpenGithubRepo", function(_)
      local ghpath = vim.api.nvim_eval "shellescape(expand('<cfile>'))"
      local formatpath = ghpath:sub(2, #ghpath - 1)
      local repourl = "https://www.github.com/" .. formatpath
      vim.fn.system { "xdg-open", repourl }
    end, {
      desc = "Open Github Repo",
      force = true,
    })

    -- Format command
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format { async = true, lsp_fallback = true, range = range }
    end, { range = true })

    -- highlight on yank
    local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function() vim.highlight.on_yank() end,
      group = highlight_group,
      pattern = "*",
    })

    -- only show tabline when more than one tab
    vim.api.nvim_create_autocmd("User", {
      desc = "Hide tabline when only one buffer and one tab",
      pattern = "AstroBufsUpdated",
      group = vim.api.nvim_create_augroup("hidetabline", { clear = true }),
      callback = function()
        local new_showtabline = #vim.t.bufs > 1 and 2 or 1
        if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
      end,
    })
