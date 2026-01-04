return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        check_ts = true,
        ts_config = {
            lua = { "string" },
            javascript = { "template_string" },
            java = false,
        },
        disable_filetype = { "TelescopePrompt", "vim" },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = [=[[%'%"%)%>%]%)%}%,]]=],
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "Search",
            highlight_grey = "Comment",
        },
    },
    config = function(_, opts)
        local autopairs = require("nvim-autopairs")
        autopairs.setup(opts)

        -- Integration with cmp
        local cmp_ok, cmp = pcall(require, "cmp")
        if cmp_ok then
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end,
}
