.global m1p1

m1p1:
    mov r6, #4
    
    mov r4, r0
    mov r5, #0 // counter

loop:
    ldrb r3, [r4, r5] @ load the character from the string

    cmp r3, #0
    beq exit_loop

    cmp r5, #0 @ check if it's the first character
    beq capitalize

    cmp r3, #' ' @ check if it's a space
    beq capitalizeNext

    cmp r3, #'Z' @ check if the character is equal to or greater than lowercase 'a'
    ble lowercase @ if it's not, then skip

    bge skip

skip:
    add r5, r5, #1 @ inc the counter
    b loop 

capitalizeNext:
    add r5, r5, #1
    ldrb r3, [r4, r5]
    sub r3, r3, #32  @ convert lowercase to uppercase
    strb r3, [r0, r5]
    add r5, r5, #1
    b loop

capitalize:
    sub r3, r3, #32  @ convert lowercase to uppercase
    strb r3, [r0, r5]
    add r5, r5, #1
    b loop

lowercase:
    cmp r3, #'A'
    blt skip

    add r3, r3, #32  @ convert uppercase to lowercase
    strb r3, [r0, r5]
    add r5, r5, #1
    b loop

exit_loop:
    bx lr  
