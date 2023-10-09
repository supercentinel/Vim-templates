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

" Takes a filename and returns a list with the substitutions
function! s:format_file(filename)
    " TODO
    let file = readfile(a:filename)
    let formats = {'{{_user_}}': g:name, '{{_email_}}': g:email }
    let formatted_file = []
    let s:formatted_line = ''

    for line in file
        :for format in keys(formats)
            s:line, format, formats[format], 'g'):line, format, formats[format], 'g')
        :endfor

         call add(formatted_file, s:formatted_line)
    endfor

    return formatted_file
endfunction

let template = readfile(s:files[0])

let formated_file = s:format_file(s:files[0])
echo formated_file

command ScanDir call s:ScanDir(g:template_dir)
