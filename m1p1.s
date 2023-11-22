.global m1p1
m1p1:
    push {r4-r7, lr}  // Save registers
    mov r4, r0  // Copy pointer to r4
    mov r6, #1  // Initialize flag for first character of a word

convert_loop:
    ldrb r5, [r4]  // Load byte at pointer
    cmp r5, #0  // Check for end of string
    beq end_convert  // If end of string, exit loop

    cmp r6, #1  // Check if it's the first character of a word
    beq convert_uppercase

    cmp r5, #65  // Check if character is uppercase
    blt convert_lowercase
    cmp r5, #90
    bgt convert_lowercase

convert_uppercase:
    sub r5, r5, #32  // Convert to uppercase
    strb r5, [r4]  // Store converted character
    moveq r6, #0  // Reset flag if character was converted to uppercase
    b next_char

convert_lowercase:
    cmp r5, #97  // Check if character is lowercase
    blt next_char
    cmp r5, #122
    bgt next_char

    add r5, r5, #32  // Convert to lowercase
    strb r5, [r4]  // Store converted character

next_char:
    add r4, r4, #1  // Move to next character
    ldrb r5, [r4]  // Load byte at pointer for the next character
    cmp r5, #32  // Check if next character is a space
    moveq r6, #1  // Set flag if it's a space
    b convert_loop  // Repeat loop

end_convert:
    pop {r4-r7, pc}  // Restore registers and return
