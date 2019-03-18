; PlaatOS - Made by Bastiaan van der Plaat
    BITS 16
    CPU 8086
    ORG 0

    jmp short os_main
    nop
    jmp os_print_string
    jmp os_print_newline
    jmp os_wait_for_key
    jmp os_input_string

os_main:
    mov ax, cs
    mov ds, ax

    mov ah, 0
    mov al, 3
    int 0x10

    mov si, welcome_text
    call os_print_string

os_command_prompt:
    mov si, prompt_text
    call os_print_string

    mov di, command_buffer
    call os_input_string
    call os_print_newline

    cmp byte [ds:command_buffer], 0
    je os_command_prompt

    mov si, command_buffer
    call os_print_string
    call os_print_newline

    mov si, pause_text
    call os_print_string
    call os_wait_for_key
    call os_print_newline

    call load_hello

    jmp os_command_prompt

    welcome_text db "Welcome to PlaatOS! ", 13, 10, 0
    prompt_text db "> ", 0
    pause_text db "Press any key to continue...", 0
    command_buffer times 32 db 0

load_hello:
    mov ax, 0x0050
    mov es, ax
    mov bx, 0x8000

    mov ah, 2
    mov al, 1
    mov ch, 0
    mov cl, 3
    mov dh, 0
    ; mov dl, 0
    int 0x13

    call 0x8000

    ret

os_print_newline:
    mov ah, 0x0e
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    ret

os_print_string:
    mov ah, 0x0e
.repeat:
    mov al, byte [ds:si]
    cmp al, 0
    je .done
    int 0x10
    inc si
    jmp .repeat
.done:
    ret

os_wait_for_key:
    mov ah, 0x10
    int 0x16
    ret

os_input_string:
    mov cx, 0
.repeat:
    mov ah, 0x10
    int 0x16

    cmp al, 13
    je .done

    cmp al, 8
    je .backspace

    cmp cx, 32 - 1
    je .repeat

    cmp al, ' '
    jb .repeat
    cmp al, '~'
    ja .repeat

    mov ah, 0x0e
    int 0x10

    mov byte [ds:di], al
    inc di
    inc cx
    jmp .repeat
.backspace:
    cmp cx, 0
    je .repeat

    mov ah, 0x0e
    mov al, 8
    int 10h
    mov al, 32
    int 10h
    mov al, 8
    int 10h

    dec di
    dec cx
    jmp .repeat
.done:
    mov byte [ds:di], 0
    ret

    times 512 - ($ - $$) db 0
