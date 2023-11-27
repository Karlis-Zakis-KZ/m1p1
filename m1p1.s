.global m1p1
m1p1:
    push {r4-r7, lr}  // Save registers
    mov r4, r0  // Copy pointer to r4
    mov r6, #1  // Initialize flag for first character of a word

convert_loop:
    ldrb r5, [r4]  // Load byte at pointer
    
    cmp r5, #0  // Check for end of string
    beq end_convert  // If end of string, exit loop

    cmp r5, #32  // Check for space
    beq next_andsetglag

    cmp r5, #97  // Check if character is lowercase
    blt skip_character

    cmp r5, #122
    bgt next_char

    cmp r6, #1  // If flag is set, convert to uppercase
    beq capitalize

skip_character:
    cmp r6, #0  // If flag is not set, convert to lowercase
    beq make_lowercase

    b next_char

capitalize:
    sub r5, r5, #32  // Convert to uppercase
    strb r5, [r4]  // Store converted character
    mov r6, #0
    b next_char

make_lowercase:
    add r5, r5, #32  // Convert to lowercase
    strb r5, [r4]  // Store converted character
    mov r6, #0
    b next_char

next_andsetglag:
    mov r6, #1
    b next_char

next_char:
    add r4, r4, #1  // Move to next character
    b convert_loop  // Repeat loop

end_convert:
    pop {r4-r7, pc}  // Restore registers and return
