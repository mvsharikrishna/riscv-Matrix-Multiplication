_start:
.data
	matrix_ia: .byte 1,2,3,4,5,6			#input matrix 1
	matrix_ib: .byte 1,2,3,4,5,6			#input matrix 2
	matrix_op: .byte 0,0,0,0,0,0,0,0,0		#output product matrix
.text
	and s0,s0,x0					# Number of rows of matrix_ia
	and s1,s1,x0					# Number of columns of matrix_ia
	and s2,s2,x0					# Number of rows of matrix_ib
	and s3,s3,x0					# Number of columns of matrix_ib
	and s4,s4,x0
	and s5,s5,x0
	and s6,s6,x0
	and s7,s7,x0

	andi t0,t0,0					# Address of matrix_ia
	andi t1,t1,0					# Address of matrix_ib
	andi t2,t2,0					# Address of matrix_op
	andi t3,t3,0					# itteration variable for loop 1
	andi t4,t4,0					# itteration variable for loop 2
	andi t5,t5,0					# itteration variable for loop 3
	andi t6,t6,0

#initialising rows and columns
	addi s0,s0,2						# rows(matrix_ia) = 2
	addi s1,s1,3						# columns(matrix_ia) = 3
	addi s2,s2,3						# rows(matrix_ib) = 3
	addi s3,s3,2						# columns(matrix_ib) = 2 
	la t0, matrix_ia					# loads base address of matrix_ia
	la t1, matrix_ib					# loads base address of matrix_ib
	la t2, matrix_op					# loads base address of matrix_op
	la t6, matrix_ib					# loads base address of matrix_ib

	bne s1, s2, end					# check condition: columns(matrix_ia) != rows(matrix_ib) => goto error label
	
	bge t3, s0, end
		loop1: and t4, x0, x0
			loop2: and t5, x0, x0
				   add s7,x0,x0
				loop3: lb s4, 0x0(t0)		# loading element from matrix_ia
					 lb s5, 0x0(t1)		# loading element from matrix_ib
					 mul s6, s4, s5		# multiplying s4 & s5
					 add s7, s6, s7		# summation of product to prev product
					 addi t0, t0, 1		# incrementing index of matrix_ia
					 add t1, t1, s3		# incrementing index of matrix_ib
					 addi t5, t5, 1		# incrementing itteration variable
					 blt t5, s2, loop3	# looping
				sb  s7, 0(t2)			# storing result in matrix_op
				addi t2, t2, 1			# incrementing index of matrix_op
				sub t0, t0, s1			# retriving to first element of row of matrix_ia
				addi t4, t4, 1			# incrementing itteration variable
				add t1, t4, t6			# retriving to first element of column of matrix_ib
				blt t4, s3, loop2			# looping
			add t0, t0, s1				# incrementing t0 next row of matrix_ia
			add t1, x0, t6				# retriving t1 to first element of matrix_ib
			addi t3, t3, 1				# incrementing itteration variable
			blt t3, s0, loop1				# looping
		jal end

#prompt: .ascii "Matrix Multiplication is not possible"

end: nop