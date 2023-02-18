; Get next subset of Goombas


; test

; ldi r29, 3 ; load toal # of set bits to compare
; call addBits

; main
ldi r17, 3
ldi r16, 128
ldi r19, 0  ; num of set bits from r17
ldi r18, 0  ; num of set bits from r16
ldi r20, 1  ; load 1 on r20
ldi r23, 0  ; load 0 on r23 for adc purpose

mov r21, r17  ; make copy of upper bits
call countUpperSetBits



nextOperation:
    ; clearing bits for next operation
    eor r21, r21
    eor r22, r22

    mov r21, r16 ; make copy of lower bits
    call countLowerSetBits

countUpperSetBits:
    mov r22, r21  ; load r17 on r22
    and r22, r20  ; r22 = r22 & r20
    add r19, r22  ; count
    lsr r21
    cpi r21, 0
    brbs 1, nextOperation
    call countUpperSetBits

countLowerSetBits:
    mov r22, r21   ; load r16 on r22
    and r22, r20   ; r22 = r22 & r20
    add r18, r22   ; count
    lsr r21
    cpi r21, 0
    brbs 1, checkForNextSubset
    call countLowerSetBits


checkForNextSubset:
    ; clearing bits
    eor r21, r21
    eor r22, r22

    mov r1, r17
    mov r0, r16

    add r19, r18  ; add total # of set bits in r19
    mov r10, r19  ; store toal number of set bits from r17 and r19 => r10

    ; clear bits for next count
    eor r19, r19
    eor r18, r18

    call addUntillNextSubset
    nop

addUntillNextSubset:
    add r0, r20
    adc r1, r23
    mov r21, r1
    call countUpperBits


countUpperBits:
    mov r22, r21  ; load r17 on r22
    and r22, r20  ; r22 = r22 & r20
    add r19, r22  ; count
    lsr r21
    cpi r21, 0
    brbs 1, nextOps
    call countUpperBits

nextOps:
    ; clearing bits for next operation
    eor r21, r21
    eor r22, r22

    mov r21, r0 ; make copy of lower bits
    call countLowerBits

countLowerBits:
    mov r22, r21  ; load r17 on r22
    and r22, r20  ; r22 = r22 & r20
    add r18, r22  ; count
    lsr r21
    cpi r21, 0
    brbs 1, checkCounts
    call countLowerBits

checkCounts:
    add r19, r18
    mov r11, r19

    ; clear bits
    eor r19, r19
    eor r18, r18
    eor r21, r21
    eor r22, r22

    cp r10, r11
    brbc 1, addUntillNextSubset
    nop
