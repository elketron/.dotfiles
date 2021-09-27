local ls = require'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

local function copy(args)
	return args[1]
end

local function char_count_same(c1, c2)
	local line = vim.api.nvim_get_current_line()
	local _, ct1 = string.gsub(line, c1, '')
	local _, ct2 = string.gsub(line, c2, '')
	return ct1 == ct2
end

local function even_count(c)
	local line = vim.api.nvim_get_current_line()
	local _, ct = string.gsub(line, c, '')
	return ct % 2 == 0
end

local function neg(fn, ...)
	return not fn(...)
end

ls.snippets = {
	all = {
		s({trig="("}, { t({"("}), i(1), t({")"}), i(0) }, neg, char_count_same, '%(', '%)'),
		s({trig="{"}, { t({"{"}), i(1), t({"}"}), i(0) }, neg, char_count_same, '%{', '%}'),
		s({trig="["}, { t({"["}), i(1), t({"]"}), i(0) }, neg, char_count_same, '%[', '%]') ,
		s({trig="<"}, { t({"<"}), i(1), t({">"}), i(0) }, neg, char_count_same, '<', '>'),
		s({trig="'"}, { t({"'"}), i(1), t({"'"}), i(0) }, neg, even_count, '\''),
		s({trig="\""}, { t({"\""}), i(1), t({"\""}), i(0) }, neg, even_count, '"'),
		s({trig="{;"}, { t({"{","\t"}), i(1), t({"", "}"}), i(0) }),
	},

	cpp = {
		ls.parser.parse_snippet(
				"cout",
				"std::cout << ${1:/* words */} << '\n';"
			),
		ls.parser.parse_snippet(
				"cin",
				"std::cin >> ${1:var};"
			),
		ls.parser.parse_snippet(
				"inc",
				"#include <${1:lib}>"
			),
		s("main",{
			t("int main (int argc, char *argv[]) {"),
			t("	"),	i(1,"/* code here */"),
			t("return 0;\n\r}"),
		}),
		s("while",{
			t("while ("), i(1,"condition"), t("){"),				t("	"), i(2,"/* code */"),
			t("}"),
		}),
		s("for", {
			t("for ("), i(1), t(" = "), i(2), i(1), i(3), i(1), t("++){"),
			i(4, "/* code */"),
			t("}"),
		}),
		s("rfor",{				t("for ("), i(1,"var"), i(2,"Val"), t(" : "), i(3,"collection"), t("){"),
			i(0,"/* code */"),
			t("}"),
		}),
		s("dow", {
			t("do {"),
			i(2, "/* code */"),
			t("} while ("), i(1,"condition"), t(")\n};"),
		}),
		s("if", {
			t("if ("), i(1,"condition"), t("){"),
			t("	"), i(2,"/* code */"),
			t("}"),
		}),
		
		s("switch",{
			t("switch ("), i(1, "expression"), t("){"),
			t("	"), i(2),
			t("}"),
		}),

		s("case", {
			t("case"), i(1), t(":"),
			t("	"), i(2,"statement"),
			t("break;"),
		}),
	}
}
