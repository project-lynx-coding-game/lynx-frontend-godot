extends CodeEdit

const keywords = ['and', 'assert', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else',
'except', 'exec', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda',
'not', 'or', 'pass', 'print', 'raise', 'return', 'try', 'while', 'yield', 'None', 'True', 'False']

# TODO add highlighting actions

# taken from dracula theme
const keyword_color = "#8be9fd"
const comment_color = "#6272a4"
const string_color = "#f1fa8c"

const background_color = "#282a36"
const function_color = "#50fa7b"
const number_color = "#ffb86c"
const current_line_color = "#44475a"
const symbol_color = "#f8f8f2"
const member_variable_color = "#f8f8f2"

func _ready():
	for k in keywords:
		syntax_highlighter.add_keyword_color(k, Color(keyword_color))
	
	syntax_highlighter.add_color_region('#', '', Color(comment_color), true)
	syntax_highlighter.add_color_region('"', '"', Color(string_color))
	
	syntax_highlighter.set_function_color(function_color)
	syntax_highlighter.set_number_color(number_color)
	syntax_highlighter.set_symbol_color(symbol_color)
	syntax_highlighter.set_member_variable_color(member_variable_color)
	add_theme_color_override("background_color", Color(background_color))
	add_theme_color_override("current_line_color", Color(current_line_color))
