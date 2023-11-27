.global m1p1
m1p1:
    push {r4-r7, lr}  // Save registers
    mov r4, r0  // Copy pointer to r4
    mov r6, #1  // Initialize flag for first character of a word

convert_loop:
    ldrb r5, [r4]  // Load byte at pointer
    cmp r5, #0  // Check for end of string
    beq end_convert  // If end of string, exit loop

    cmp r5, #' '
    moveq r6, #1  // Set flag if character is a space
    beq next_char  // Skip to next character if space

    cmp r5, #122  // Check if character is uppercase
    bgt next_char  // Skip to next character if uppercase

    cmp r5, #65  // Check if character is lowercase
    blt next_char  // Skip to next character if not lowercase

    cmp r5, #'a'  // Check if character is lowercase
    bge checkifneedswork  // Skip to next character if not lowercase

    cmp r5, #'Z'  // Check if character is lowercase
    bge lowercase


checkifneedswork:
    cmp r6, #1  // Check if first character of a word
    beq capitalize  // If first character, capitalize

    bne next_char  // If not first character, skip to next character

lowercase:
    add r5, r5, #32  // Convert to lowercase
    strb r5, [r4]  // Store lowercase character
    b next_char  // Skip to next character

capitalize:
    sub r5, r5, #32  // Convert to uppercase
    strb r5, [r4]  // Store uppercase character
    mov r6, #0  // Clear flag
    b next_char  // Skip to next character

next_char:
    add r4, r4, #1  // Move to next character
    b convert_loop  // Repeat loop

end_convert:
    pop {r4-r7, pc}  // Restore registers and return
