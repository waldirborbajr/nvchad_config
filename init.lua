
    vim.api.nvim_create_autocmd("User AstroFile", {
      desc = "no auto comment after pressing o",
      pattern = "*",
      command = "setlocal formatoptions-=o",
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
