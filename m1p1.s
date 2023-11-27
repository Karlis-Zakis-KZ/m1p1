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
    moveq r6, #1  // If space, set flag to uppercase next character
    beq next_char

    cmp r5, #97  // Check if character is lowercase
    blt skip_charater
    moveq r6, #0
    cmp r5, #122
    bgt next_char
    moveq r6, #0

    cmp r6, #1  // If flag is set, convert to uppercase
    beq capitalize

skip_charater:
    cmp r5, #65  // Check if character is uppercase
    blt next_char
    cmp r5, #90
    bgt next_char

    cmp r6, #0  // If flag is set, convert to lowercase
    add r5, r5, #32  // Convert to lowercase
    strb r5, [r4]  // Store converted character
    b next_char

capitalize:
    sub r5, r5, #32  // Convert to uppercase
    strb r5, [r4]  // Store converted character
    moveq r6, #0  // Reset flag
    b next_char

next_char:
    add r4, r4, #1  // Move to next character
    b convert_loop  // Repeat loop

end_convert:
    pop {r4-r7, pc}  // Restore registers and return
