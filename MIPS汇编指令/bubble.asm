.text
	addi	$2, $2, 6
	addi	$3, $3, 5
	addi	$4, $4, 4
	addi	$5, $5, 3
	addi	$6, $6, 2
	addi	$9, $9, 0
	
label1:	sub	$7, $7, $7
	slt	$8, $5, $6
	beq	$8, $9, label5
label2:	slt	$8, $4, $5
	beq	$8, $9, label6
label3:	slt	$8, $3, $4
	beq	$8, $9, label7
label4:	slt	$8, $2, $3
	beq	$8, $9, label8
label9:	bne	$7, $9, label1
	beq	$7, $9, label10
	
label5:	addi	$10, $5, 0
	addi	$5, $6, 0
	addi	$6, $10, 0
	addiu	$7, $7, 1
	j	label2
	
label6:	addi	$10, $4, 0
	addi	$4, $5, 0
	addi	$5, $10, 0
	addiu	$7, $7, 1
	j	label3
	
label7:	addi	$10, $3, 0
	addi	$3, $4, 0
	addi	$4, $10, 0
	addiu	$7, $7, 1
	j	label4
	
label8:	addi	$10, $2, 0
	addi	$2, $3, 0
	addi	$3, $10, 0
	addiu	$7, $7, 1
	j	label9
	
label10:
