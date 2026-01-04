local M = {}

M.__index = M

setmetatable(M, {
    __call = function(cls, opts)
        return cls:ZoomFont(opts)
    end,
})

function M:ZoomFont(delta)
    local font = vim.o.guifont
    local colon, h = string.find(font, ":h")
    local font_name = string.sub(font, 1, colon - 1)
    local size = tonumber(string.sub(font, h+1, string.len(font)))
    size = size + delta
    vim.o.guifont = font_name .. ":h" .. size
end

return M
