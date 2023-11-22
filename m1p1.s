.global m1p1
m1p1:
    push {lr}              @ save the return address
    mov r1, #0             @ initialize a flag to check if the previous character was a space

convert:
    ldrb r2, [r0], #1      @ load the current character into r2 and increment the pointer
    cmp r2, #0             @ compare the current character with null
    beq end                @ if it's null, we've reached the end of the string, so branch to end

    cmp r2, #' '           @ compare the current character with space
    moveq r1, #1           @ if it's a space, set the flag to 1
    bne next               @ if it's not a space, branch to next

next:
    cmp r1, #1             @ check if the previous character was a space
    bne lower              @ if it wasn't, branch to lower
    sub r2, r2, #'a'-'A'   @ if it was, convert the current character to uppercase
    strb r2, [r0, #-1]     @ store the converted character back into the string
    mov r1, #0             @ reset the flag
    b convert              @ branch back to convert

lower:
    cmp r2, #'a'
    blt convert            @ if the character is not a lowercase letter, branch back to convert
    cmp r2, #'z'
    bgt convert            @ if the character is not a lowercase letter, branch back to convert
    strb r2, [r0, #-1]     @ store the lowercase character back into the string
    b convert              @ branch back to convert

end:
    pop {pc}               @ return to the caller
