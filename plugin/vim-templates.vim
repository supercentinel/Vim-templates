"TODO create function to get the current date
let s:date = '2019-01-01'

" Dictionary with the formats to replace
let s:formats = {
    \'{{_author_}}': g:author,
    \'{{_email_}}': g:email,
    \'{{_file_name_}}': '',
    \'{{_upper_file_}}': '',
    \'{{_date_}}': s:date,
\}
" Scans the template dir and returns a list with the files
function! s:ScanDir(template_dir)
    let expanded_dir = expand(a:template_dir)
    let files = systemlist('find ' . shellescape(expanded_dir) . ' -type f')
    call filter(files, 'v:val =~ "[^.]*$"')

    return files
endfunction

" Takes a filename and returns a list with the substitutions
function! s:format_file(filename)
    let file = readfile(a:filename)
    let formatted_file = []

    for line in file
        let s:formatted_line = line

        :for format in keys(s:formats)
            let s:formatted_line = substitute(s:formatted_line, format, s:formats[format], 'g')
        :endfor

         call add(formatted_file, s:formatted_line)
    endfor

    return formatted_file
endfunction
" Inserts formatted list in the current buffer
function s:InsertTemplate(format_file)
    for line in a:format_file
        :call append(line('$'), line)
    endfor
endfunction
" TODO: asign a value for name based on selection for Template command

let s:files = s:ScanDir(g:template_dir)

" shorted filenames for autocomplete
let s:short_files = deepcopy(s:files)
call map(s:short_files, 'fnamemodify(v:val, ":t")')


function s:CreateFilesDict(files, shorted_files)
    let s:files_dict = {}
    let s:i = 0

    for file in a:files
        call extend(s:files_dict, {a:shorted_files[s:i]: file})
        let s:i += 1
    endfor

    return s:files_dict
endfunction

let s:files_dict = s:CreateFilesDict(s:files, s:short_files)

"TODO create autocomplete for as user inputs
function s:CustomComplete(ArgLead, CmdLine, CursorPos)
    return s:short_files
endfunction

function s:Template(Template, filename, ...)
    let s:formats['{{_file_name_}}'] = a:filename
    let s:formats['{{_upper_file_}}'] = toupper(a:filename)

    let s:Template_location = s:files_dict[a:Template]

    let s:formated_file = s:format_file(s:Template_location)
    call s:InsertTemplate(s:formated_file)
endfunction

function s:UpdateTemplates()
    let s:files = s:ScanDir(g:template_dir)

    echo s:files

    let s:short_files = deepcopy(s:files)
    call map(s:short_files, 'fnamemodify(v:val, ":t")')

    let s:files_dict = s:CreateFilesDict(s:files, s:short_files)
endfunction

command! UpdateTemplates call s:UpdateTemplates()
command! -nargs=* -complete=customlist,s:CustomComplete Template call s:Template(<f-args>)
