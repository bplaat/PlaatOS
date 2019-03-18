; PlaatOS - Made by Bastiaan van der Plaat
    %include "plaatos-dev.asm"

    mov si, hello_message
    call os_print_string

    call os_wait_for_key
    call os_print_newline

    mov di, name_buffer
    call os_input_string
    call os_print_newline

    mov si, name_buffer
    call os_print_string
    call os_print_newline

    ret

    hello_message db "Hello World...", 0
    name_buffer times 32 db 0

    times 512 - ($ - $$) db 0
