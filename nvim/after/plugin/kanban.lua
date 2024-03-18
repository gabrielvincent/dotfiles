local HOME = os.getenv("HOME")

require("kanban").setup({
	markdown = {
		description_folder = HOME .. "/.kanban/", -- Path to save the file corresponding to the task.
		list_head = "## ",
	},
})
