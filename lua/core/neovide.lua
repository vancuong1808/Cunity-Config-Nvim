if vim.g.neovide then
    vim.o.guifont = "JetBrainsMonoNL Nerd Font Propo:h10.5"
    vim.opt.linespace = 0
    vim.g.neovide_scale_factor = 1.0 --Scale chữ mà 0 cần thay đổi kích cỡ font

    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0

    vim.g.neovide_fullscreen = true

    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_scroll_animation_far_lines = 1

    vim.g.neovide_progress_bar_enabled = true
    vim.g.neovide_progress_bar_height = 5.0
    vim.g.neovide_progress_bar_animation_speed = 200.0
    vim.g.neovide_progress_bar_hide_delay = 0.2

    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_underline_stroke_scale = 2.0
    vim.g.neovide_theme = 'auto'

    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_cursor_hack = true
    vim.g.neovide_profiler = false --Hien thi GPU, performance

    --Setup cho dùng ime
    local function set_ime_cb(args)
        local enable = args.event:match("Enter$") ~= nil
        vim.g.neovide_input_ime = enable
    end
    local ime_group = vim.api.nvim_create_augroup("ime_event", { clear = true })
    vim.api.nvim_create_autocmd({"InsertEnter", "InsertLeave"}, {
        group = ime_group,
        pattern = "*",
        callback = set_ime_cb
    })
    vim.api.nvim_create_autocmd({"CmdlineEnter", "CmdlineLeave"}, {
        group = ime_group,
        pattern = "[\\/?]",
        callback = set_ime_cb
    })
    
    vim.g.neovide_touch_deadzone = 6.0
    vim.g.neovide_touch_drag_timeout = 0.17

    vim.g.neovide_cursor_trail_length = 0.6
    vim.g.neovide_cursor_animation_length = 0.15
    vim.g.neovide_cursor_short_animation_length = 0.04
    vim.g.neovide_cursor_trail_size = 1.0
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_unfocused_outline_width = 0.125
    vim.g.neovide_cursor_smooth_blink = true
    vim.g.neovide_cursor_vfx_mode = "railgun" --Làm helper chuyển đổi cái này {"", pixiedust, sonicboom, torpedo, railgun, wireframe, ripple}

    vim.g.neovide_cursor_vfx_opacity = 200.0
    vim.g.neovide_cursor_vfx_particle_highlight_lifetime = 0.5 --Thời gian hạt, vfs tồn tại cho sonicboom, ripple, wireframe
    vim.g.neovide_cursor_vfx_particle_lifetime = 0.7 --Đây là phần còn lại nếu 0 liệt kê ở trên
    vim.g.neovide_cursor_vfx_particle_density = 0.7
    vim.g.neovide_cursor_vfx_particle_speed = 50.0
    vim.g.neovide_cursor_vfx_particle_phase = 1.5
    vim.g.neovide_cursor_vfx_particle_curl = 1.0
    vim.g.neovide_has_mouse_grid_detection = true

    vim.g.neovide_floating_corner_radius = 16.0 --Floating windows làm bo góc
    -- vim.g.neovide_window_blurred = true
    vim.g.neovide_opacity = 1.0
    vim.g.neovide_normal_opacity = 0.8
    -- vim.g.neovide_floating_z_height_scale = 1.0
    -- vim.g.neovide_floating_blur = true
    -- vim.g.neovide_floating_blur_amount_x = 2.0
    -- vim.g.neovide_floating_blur_amount_y = 2.0

    if vim.fn.has("win32") == 1 then
        print("Neovide Register has runned")
        vim.cmd("NeovideRegisterRightClick")
    end
end
