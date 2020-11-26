.text
	addiu   $2, $2, 0
	addiu  	$3, $3, 1
	addiu 	$4, $4, 6
	addiu	$5, $5,	1
	addiu	$6, $6, 2
	beq	$4, $5, label1
	beq	$4, $6, label2
	
label3:	addiu	$7, $3, 0
	addu	$3, $3, $2
	addiu	$2, $7, 0
	addiu	$6, $6, 1
	bne	$6, $4, label3
	beq	$6, $4, label4

label1:	addiu	$3, $2, 0
	j	label4
	
label2:	addiu	$3, $3, 0
	j	label4
	
label4:	addiu	$1, $3, 0	
.text	ends
