; PlaatOS - Made by Bastiaan van der Plaat
; http://stanislavs.org/helppc/int_13.html
    BITS 16
    CPU 8086
    ORG 0x7c00

    jmp short start
    nop
    OEMLabel db "PLAATOS "
    SectorSize dw 512
    SectorsPerCluster db 1
    ReservedForBoot dw 1
    NumberOfFats db 2
    RootDirEntries dw 224
    LogicalSectors dw 2880
    MediumByte db 0xf0
    SectorsPerFat dw 9
    SectorsPerTrack dw 18
    NumberOfHeads dw 2
    HiddenSectors dd 0
    LargeSectors dd 0
    DriveNumber dw 0
    Signature db 0x29
    VolumeID dd 0x00000000
    VolumeLabel db "PLAATOS    "
    FileSystem db "FAT12   "

start:

reset_disk:
    mov ah, 0
    ; mov dl, 0
    int 0x13
    jc reset_disk

    mov ax, 0x0050
    mov es, ax
    mov bx, 0

    mov ah, 2
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    ; mov dl, 0
    int 0x13

    jmp 0x0050:0

    times 510 - ($ - $$) db 0
    dw 0xaa55
