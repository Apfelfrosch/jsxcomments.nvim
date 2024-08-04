local comment_start = "{/*"
local comment_end = "*/}"

function ToggleJsxCommentsVisual()
    local text_start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local text_end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))

    if text_start_row == 0 or text_end_row == 0 then
        print("JSXComments: Could not comment due to visual marks not set")
        return
    end

    local amount_lines = math.abs(text_end_row - text_start_row)
    local cursor_pos_now = vim.api.nvim_win_get_cursor(0)

    for i=0,amount_lines do
        local line_text = vim.api.nvim_buf_get_lines(0, text_start_row + i - 1, text_start_row + i, false)[1]
        vim.api.nvim_win_set_cursor(0, {i + text_start_row, 0})

        line_text = string.gsub(line_text, "%s+", "")

        if string.len(line_text) >= string.len(comment_start) and string.sub(line_text, 0, string.len(comment_start)) == comment_start then
            vim.cmd("norm! ^v" .. (string.len(comment_start) - 1) .. "ldg_v" .. (string.len(comment_end) - 1) .. "hd")
        else
            vim.api.nvim_put({comment_start}, "", false, false)
            vim.cmd("norm! $")
            vim.api.nvim_put({comment_end}, "", true, false)
        end
    end

    vim.api.nvim_win_set_cursor(0, cursor_pos_now)
end

vim.api.nvim_create_user_command("JsxCommentVisual", ToggleJsxCommentsVisual, {})
