.global m1p1

m1p1:
    mov r6, #4  // Initialize counter
    mov r4, r0  // Copy pointer to r4
    mov r5, #0  // Initialize counter for characters

loop:
    ldrb r3, [r4, r5]  // Load byte at pointer
    cmp r3, #0  // Check for end of string
    beq end_convert  // If end of string, exit loop

    cmp r3, #32  // Check for space
    beq capitalizeNext  // If space, skip to next character

    cmp r3, #'a'  // Check if character is lowercase
    blt skip_charater
    cmp r3, #'z'
    bgt skip_charater

    cmp r6, #0  // If flag is set, convert to uppercase
    subeq r3, r3, #32  // Convert to uppercase
    moveq r6, #0  // Reset flag
    strb r3, [r4, r5]  // Store converted character
    beq next_char

skip_charater:
    cmp r3, #'A'  // Check if character is uppercase
    blt next_char
    cmp r3, #'Z'
    bgt next_char

    cmp r6, #1  // If flag is set, convert to lowercase
    add r3, r3, #32  // Convert to lowercase
    strb r3, [r4, r5]  // Store converted character
    b next_char

capitalizeNext:
    add r5, r5, #1  // Move to next character
    ldrb r3, [r4, r5]
    sub r3, r3, #32  // Convert lowercase to uppercase
    strb r3, [r4, r5]  // Store converted character
    b loop

next_char:
    add r5, r5, #1  // Move to next character
    cmp r5, r6  // Check if counter reached end
    ble loop  // Repeat loop if not

end_convert:
    bx lr  // Return
