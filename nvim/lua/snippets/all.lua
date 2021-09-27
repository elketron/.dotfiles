-- snippets for all languages
require('.global')

all = {
	s({trig="("}, { t({"("}), i(1), t({")"}), i(0) }, neg, char_count_same, '%(', '%)'),
		s({trig="{"}, { t({"{"}), i(1), t({"}"}), i(0) }, neg, char_count_same, '%{', '%}'),
		s({trig="["}, { t({"["}), i(1), t({"]"}), i(0) }, neg, char_count_same, '%[', '%]') ,
		s({trig="<"}, { t({"<"}), i(1), t({">"}), i(0) }, neg, char_count_same, '<', '>'),
		s({trig="'"}, { t({"'"}), i(1), t({"'"}), i(0) }, neg, even_count, '\''),
		s({trig="\""}, { t({"\""}), i(1), t({"\""}), i(0) }, neg, even_count, '"'),
		s({trig="{;"}, { t({"{","\t"}), i(1), t({"", "}"}), i(0) }),
}
