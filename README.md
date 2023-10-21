# Vim-Templates

This is a plugin intended for saving time typing or copy and pasting
from other sources. Right now is more like a snippet plugin.

## Causes

I created this plugin to help me avoiding coping and pastig from other files.
I tried to use the plugin of [nvimdev](https://github.com/nvimdev) but didn't work as i still use a vimscript init file.

As such, i tried to implement the same features from his [plugin](https://github.com/nvimdev/template.nvim)

## Instalation

For using this plugin install with a plugin manager

## Usage

For using this plugin you need to set up some variables in your `.vimrc/vim.init`

`let g:template_dir`: for specifing the directory where you store your templates
`let g:name` for the author name substitution in the templates
`let g:email` for inserting your designated email in your template

You define this substitutions in your template as the following

- `{{_user_}}`
- `{{_email_}}`
- `{{_file_name_}}`
- `{{_upper_file_}}`
- `{{_date_}}`

You could also add custom substitutions in the source file as this is defined as a dictionary.

## Example

The primary use i will give this plugin is for rapidly creating templates(*duh*)
for C++ and $\LaTeX$ documents: here's are the examples

my `g:template_dir` is set as `~/Templates`(**it scans dirs recursively!**)

### For $\LaTeX$

```
A\documentclass[border=10pt]{standalone}
\usepackage{tikz}
\usepackage{geometry}

\usetikzlibrary{mindmap}

\author{ {{_author_}} }
%{{_date_}
\geometry{landscape, margin=1cm}


\begin{document}
\begin{center}
\begin{tikzpicture}[small mindmap, grow cyclic,every node/.style=concept, concept color=red!80, text=black!90,
    level 1/.append style={level distance=4cm,sibling angle=90},
    level 2/.append style={level distance=3cm,sibling angle=45},
    level 3/.append style={level distance=2cm,sibling angle=45}]
    \node{ {{_file_name_}} }
        child[concept color=purple!60] { node { {{_cursor_}} } }
    ;
\end{tikzpicture}
\end{center}
\end{document}
```

