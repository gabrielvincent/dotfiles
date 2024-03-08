local ls = require("luasnip")

local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.setup({ update_events = { "TextChanged", "TextChangedI" } })

local function copy(args)
	return args[1]
end

local js_clog_snippet = s(
	"clog",
	fmt(
		[[
    console.log(`--- {1}`, {2})
    ]],
		{ i(1), i(2) }
	)
)

local javascript_snippets = {
	js_clog_snippet,
}

local typescript_snippets = {
	s(
		"rfc",
		fmt(
			[[
      import * as React from 'react'

      type Props = {{}}

      export function {1}({{}}: Props) {{
        return {2}
      }}
    ]],
			{ i(1, "ComponentName"), i(2, "...") }
		)
	),
	s(
		"rue",
		fmt(
			[[
    React.useEffect(() => {{
        {1}
    }}, [{2}])
    ]],
			{ i(1), i(2) }
		)
	),
	s("rus", {
		t("const ["),
		f(copy, { 1 }, "Will be appended to text from i(0)"),
		i(1),
		t(", set_"),
		i(1),
		t("] = React.useState<"),
		i(2, "type"),
		t(">("),
		i(3, "initial"),
		t(")"),
		i(0),
	}),
}

local go_snippets = {
	s(
		"log",
		fmt(
			[[
    log.Printf(`--- {1}`, {2})
    ]],
			{ i(1), i(2) }
		)
	),
}

local liquid_snippets = {
	s(
		"llog",
		fmt(
			[[
    <script>console.log(`--- {1}: `, {{ {2} }})</script>
    ]],
			{ i(1), i(2) }
		)
	),
}

local html_snippets = {
	js_clog_snippet,
}

ls.add_snippets("javascript", javascript_snippets)
ls.add_snippets("typescript", javascript_snippets)
ls.add_snippets("typescript", typescript_snippets)
ls.add_snippets("typescriptreact", javascript_snippets)
ls.add_snippets("typescriptreact", typescript_snippets)
ls.add_snippets("go", go_snippets)
ls.add_snippets("liquid", liquid_snippets)
ls.add_snippets("html", html_snippets)

local M = {}

function M.expand_or_jump()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end

function M.jump_next()
	if ls.jumpable(1) then
		ls.jump(1)
	end
end

function M.jump_prev()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end

function M.change_choice()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end

function M.reload_package(package_name)
	for module_name, _ in pairs(package.loaded) do
		if string.find(module_name, "^" .. package_name) then
			package.loaded[module_name] = nil
			require(module_name)
		end
	end
end

function M.refresh_snippets()
	ls.cleanup()
	M.reload_package("<update the module name here>")
end

local mode = { "i", "s" }
local normal = { "n" }

vim.keymap.set(mode, "<M-i>", M.expand_or_jump)
vim.keymap.set(mode, "<M-n>", M.jump_next)
vim.keymap.set(mode, "<M-p>", M.jump_prev)
vim.keymap.set(mode, "<M-l>", M.change_choice)
vim.keymap.set(normal, ",r", M.refresh_snippets)
