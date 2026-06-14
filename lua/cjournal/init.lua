local M = {}

M.config = {
	journal_dir = "~/journal",
	file_format = "%m-%d.md",
	date_format = "%d.%m.%Y",
	timestamp_format = "## %H:%M — ",
	default_keymaps = true,
	template = {
		"# Journal ${date}",
		"",
		"## Done",
		"",
		"## Books",
		"",
		"## Ideas / Todo",
		"",
	},
}

function M.open_daily_journal()
	local journal_dir = vim.fn.expand(M.config.journal_dir)

	if vim.fn.isdirectory(journal_dir) == 0 then
		vim.fn.mkdir(journal_dir, "p")
	end
	vim.api.nvim_set_current_dir(journal_dir)

	local file_name = os.date(M.config.file_format)
	local file_path = journal_dir .. "/" .. file_name
	local file_exists = vim.fn.filereadable(file_path) == 1

	vim.cmd("edit " .. vim.fn.fnameescape(file_path))

	if not file_exists then
		local formatted_date = os.date(M.config.date_format)
		local final_template = {}

		for _, line in ipairs(M.config.template) do
			-- Чиним gsub: берем строго первое возвращаемое значение (саму строку)
			local cleaned_line = (line:gsub("${date}", formatted_date))
			table.insert(final_template, cleaned_line)
		end

		vim.api.nvim_buf_set_lines(0, 0, -1, false, final_template)
		vim.cmd("write")
		vim.api.nvim_win_set_cursor(0, { 3, 0 })
	else
		vim.cmd("normal! G")
	end
end

function M.insert_timestamp()
	local timestamp = os.date(M.config.timestamp_format)

	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local current_line = vim.api.nvim_get_current_line()

	local new_line = current_line:sub(1, col) .. timestamp .. current_line:sub(col + 1)

	vim.api.nvim_set_current_line(new_line)

	local new_col = col + #timestamp
	vim.api.nvim_win_set_cursor(0, { row, new_col })

	vim.cmd("startinsert!")
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})

	vim.api.nvim_create_user_command("Journal", M.open_daily_journal, {})
	vim.api.nvim_create_user_command("JournalTime", M.insert_timestamp, {})

	if M.config.default_keymaps then
		vim.keymap.set("n", "<leader>jn", M.open_daily_journal, { desc = "Open daily journal" })
		vim.keymap.set("n", "<leader>jt", M.insert_timestamp, { desc = "Insert journal timestamp" })
	end
end

return M
