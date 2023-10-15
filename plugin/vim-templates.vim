let g:template_dir = '~/Templates'
let g:name = 'test'
let g:email = 'a374377@proton.me'

function! s:ScanDir(template_dir)
    let expanded_dir = expand(a:template_dir)
    let files = systemlist('find ' . shellescape(expanded_dir) . ' -type f')
    call filter(files, 'v:val =~ "\\.[^.]*$"')

    return files
endfunction

let s:files = s:ScanDir(g:template_dir)

let s:file_name = 'adad'
let s:upper_file = toupper(s:file_name)
let s:date = '2019-01-01'

let s:formats = {
    \'{{_user_}}': g:name,
    \'{{_email_}}': g:email,
    \'{{_file_name_}}': s:file_name,
    \'{{_upper_file_}}': s:upper_file,
    \'{{_date_}}': s:date,
\}

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

let template = readfile(s:files[0])

let s:formated_file = s:format_file(s:files[0])

function InsertTemplate(format_file)
    for line in a:format_file
        :call append(line('$'), line)
    endfor
endfunction
" TODO: create a autocomplete for Template comand based on filenames in
" template dir
" TODO: asign a value for name based on selection for Template command


" Temporary commands
command ScanDir call s:ScanDir(g:template_dir)
command InsertTemplate call InsertTemplate(s:formated_file)

