.global start

start:
	lds r24, 0x24
  ori r24, 0x20
  sts 0x24, r24

GMorse:
  call turnon
  call Wait
  call Wait
  call Wait
  call turnoff
  call Wait

  call turnon   
  call Wait
  call Wait
  call Wait 
  call turnoff
  call Wait   

  call turnon
  call Wait
  call turnoff

	call turnoff         ; 3s delay to transition to the next letter 
	call Wait
  call Wait
  call Wait	 

UMorse:
  call turnon
  call Wait      
  call turnoff
	call Wait      

  call turnon
  call Wait      
  call turnoff
	call Wait      

  call turnon
  call Wait
  call Wait
  call Wait  
  call turnoff   
 
	call Wait
  call Wait
  call Wait	

RMorse:
  call turnon
  call Wait      
  call turnoff
	call Wait      

  call turnon
  call Wait
  call Wait
  call Wait   
  call turnoff
	call Wait      

  call turnon
  call Wait      
  call turnoff

	call Wait            ; jump back to start after a delay of 5 units
  call Wait
  call Wait
	call Wait
	call Wait	
	rjmp start            

Wait:
    ldi  r28, 82	      ;  subrotine to delay for one second
    ldi  r29, 43
    ldi  r20, 0
Loops: 
    add  r20, r22
    brbc 1, Loops
    add  r29, r22
    brbc 1, Loops
    add  r28, r22
    brbc 1, Loops
    nop
    ret

turnon:
  lds r24, 0x25
  ori r24, 0x20
  sts 0x25, r24
  ret

turnoff:
  lds r24, 0x25
  andi r24, 0xdf
  sts 0x25, r24
  ret
