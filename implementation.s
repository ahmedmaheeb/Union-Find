unionfind:
        push    r12
        mov     r12, rdx	// solutionString
        push    rbp
        mov     rbp, rdi	// setSize
        cmp     rbp,  0
        je      end2
        sal     rdi, 2 		// *4 for malloc
        push    rbx
        mov     rbx, rsi	// instructionString
        call    malloc
        push	r13
        push 	r14
        mov 	r13, rax //store pointer p
        
        mov     rdi, rbp	// setSize
        sal     rdi, 2		// *4 for malloc
        call    malloc
        push 	r15
        push 	rsp
        mov 	r15, rax	 //store pointer size
        
        xor     rdx, rdx
        loop:
        // parent array, r13 start adress (return value of malloc), rdx = i
        mov 	DWORD PTR [r13+rdx*4], edx
        xor     rsi, rsi
        inc     rsi
        mov 	DWORD PTR [r15+rdx*4], esi
        mov     esi, DWORD PTR [r15+rdx*4] // for debugging
        inc 	rdx
        cmp 	rbp, rdx
        jne 	loop
      
      	whileLoop:
        // instruction ptr
        cmp 	BYTE PTR [rbx], 0
        je 		end
        
        Find:
        cmp 	BYTE PTR [rbx], 70 // instruction string in rbx
        jne 	UnionSet
        mov 	rdi, rbx
        inc		rdi
        call 	getint
        //mov 	r8, rax
        mov 	rcx, rax		// veryFirstValue
        mov 	rbx, rdi
        
        
        mov 	r14, 0 // levels
   		innerWhileLoop:
        cmp 	DWORD PTR [r13+rax*4], eax
        je 	relinking
        inc 	r14
        mov 	eax, DWORD PTR [r13+rax*4]
        jmp 	innerWhileLoop
        
        relinking:
        mov 	r8, rax		//veryLastValue
        mov		rax, rcx	//swap1
        mov 	rcx, r8		//swap2
   		innerWhileLoop2:
        cmp 	DWORD PTR [r13+rax*4], ecx
        je 		endInnerWhileLoop
        mov     edx, DWORD PTR [r13+rax*4]
        mov 	DWORD PTR [r13+rax*4], ecx
        mov     rax, rdx
        jmp 	innerWhileLoop2
       
       	endInnerWhileLoop:
        mov 	BYTE PTR [r12], 70
        inc		r12
        mov		rdi, rcx
        mov 	rsi, r12
        call 	putint
        mov	 	r12, rax
       
       	mov 	BYTE PTR [r12], 76
        inc		r12
        mov		rdi, r14
        mov		rsi, r12
        call 	putint
        mov 	r12, rax
        
        jmp endWhile
        UnionSet:
        mov 	rdi, rbx
        inc		rdi
        call 	getint
        mov 	rcx, rax		// veryFirstValue
        mov 	rbx, rdi
        FindPart1:
        mov 	r14, 0 // levels
   		innerWhileLoopPart1:
        cmp 	DWORD PTR [r13+rax*4], eax
        je 		relinkingPart1
        inc 	r14
        mov 	eax, DWORD PTR [r13+rax*4]
        jmp 	innerWhileLoopPart1
        
        relinkingPart1:
        mov 	r8, rax	//veryLastValue
        mov		rax, rcx	//swap1
        mov 	rcx, r8		//swap2
        innerWhileLoop2Part1:
        cmp 	DWORD PTR [r13+rax*4], ecx
        je 		endFindPart1
        mov     edx, DWORD PTR [r13+rax*4]
        mov 	DWORD PTR [r13+rax*4], ecx
        mov     rax, rdx
        jmp 	innerWhileLoop2Part1
        
        endFindPart1:
        mov 	rdi, rbx
        inc		rdi
        mov 	rbp, r8			//r8 sichern
        call 	getint
        mov 	rcx, rax		// veryFirstValue
        mov 	rbx, rdi
        
        FindPart2:
   		innerWhileLoopPart2:
        cmp 	DWORD PTR [r13+rax*4], eax
        je 		relinkingPart2
        mov     r9, QWORD PTR [r13+rax*4] // for debugging
        inc 	r14
        mov 	eax, DWORD PTR [r13+rax*4]
        jmp 	innerWhileLoopPart2
        
        relinkingPart2:
        mov 	r9, rax		//veryLastValue
        mov		rax, rcx	//swap1
        mov 	rcx, r9		//swap2
   		innerWhileLoop2Part2:
        cmp 	DWORD PTR [r13+rax*4], ecx
        je 		endFindPart2
        mov     edx, DWORD PTR [r13+rax*4]
        mov 	DWORD PTR [r13+rax*4], ecx
        mov     rax, rdx
        jmp 	innerWhileLoop2Part2
   		endFindPart2:
        
       	mov 	r8, rbp
        cmp		r8, r9
        je 		putInString
        mov		esi, DWORD PTR[r15+r8*4]
        mov		edi, DWORD PTR[r15+r9*4]
        cmp		edi, esi
        jg		else
        mov     rsi, r8
        mov     rdi, r9
        mov		DWORD PTR[r13+r9*4], esi
        mov		edi, DWORD PTR[r15+r9*4]
        add		DWORD PTR[r15+r8*4], edi
        mov		r9, r8
        jmp		putInString
        else:
        mov     rsi, r8
        mov     rdi, r9
        mov		DWORD PTR[r13+r8*4], edi
        mov		esi, DWORD PTR[r15+r8*4]
        add		DWORD PTR[r15+r9*4], esi

        putInString:
        mov 	BYTE PTR [r12], 85
        inc		r12
        mov		rdi, r9
        mov 	rsi, r12
        call 	putint
        mov	 	r12, rax
       
       	mov 	BYTE PTR [r12], 76
        inc		r12
        mov		rdi, r14
        mov		rsi, r12
        call 	putint
        mov 	r12, rax
endWhile:
        jmp whileLoop
        
end:	
		pop		rsp
		pop 	r15
		pop		r14
        pop		r13
        pop     rbx
        end2:
        pop     rbp
        pop     r12
        
        ret
