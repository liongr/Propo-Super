
INCLUDE	globals.inc

code	segment	public

	assume  cs:code

Make_Super_Met	proc	near
	@PUSH
	@TAKEWIND
	mov	cs:old_select,ax
	mov	cs:diakopi,sp
	@CHANGESEGM	ds,DATA
	mov	metablp,0
	@CHANGESEGM	ds,DATAS1

	mov	cs:handletmp,0

	mov	cs:epistrofi,sp
	call	zerobit

;-----------------------------------------------------------------------------
	call	Ascii_to_Buffer	;;; BALE STILES SE MNHMH H ARXEIO
;-----------------------------------------------------------------------------

	cmp	cs:handletmp,0
	je	kost1
	@ZEROBBUF	strbuf,13
	@WRITE_HANDLE	cs:handletmp,strbuf,13
	@CLOSE_HANDLE	cs:handletmp
	
kost1:	@CHANGESEGM	ds,DATA
	cmp	stiles,0
	jne	exist
	cmp	stiles[2],0
	jne	exist
	jmp	isplir

exist:	mov	ax,stiles[0]
	mov	ypoloipo[0],ax
	mov	ax,stiles[2]
	mov	ypoloipo[2],ax

;-----------------------------------------------------------------------------
	call	Take_Stiles
;-----------------------------------------------------------------------------

isplir:	call	savetelos
	mov	cs:handletmp,0
	@DELWIND	wargo
	mov	dx,cs:old_select
	@SELECTWI	dl
	@POP
	ret
epistrofi	dw	0
Make_Super_Met	endp

;******************************************************

Take_Stiles	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA
	cmp	Apo_Memory,0
	je	gen1
	call	Take_Stl_Memory
	@POP
	ret
	
gen1:	cmp	cs:handletmp,0
	je	gen1_1
	call	Take_Stl_Disk
	@POP
	ret
	
gen1_1:	@EXIT
Take_Stiles	endp

;******************************************************

Take_Stl_Memory		proc	near
	@PUSH
	call	zerobit
	@CHANGESEGM	ds,DATA
	@CHANGESEGM	es,PINS1
	xor	di,di

	mov	ax,BUF1
	mov	BUF_Pointer_A[2],ax
	mov	BUF_Pointer_A[0],0
	mov	ByteAnd_A,1

fpin12:	cmp	byte ptr es:[di],0
	je	fp1end
	xor	bx,bx
	
	mov	cx,13
fpin11:	mov	al,byte ptr es:[di]
	cmp	al,0
	jne	n001

	@WPRINTCH	0,0,"2"
	@EXIT

n001:	mov	Stili_A[bx],al
	inc	bx
	inc	di
	loop	fpin11

	call	check_stili
	jc	epp1

	call	metablito

epp1:	cmp	di,65500
	jb	fpin12
	mov	ax,es
	add	ax,4096
	mov	es,ax
	xor	di,di
	jmp	fpin12
	
fp1end:	@POP
	ret
Take_Stl_Memory	endp

;******************************************************

check_stili	proc	near
	push	es
	push	ax
	push	di
	rol	ByteAnd_A,1
	cmp	ByteAnd_A,1
	jne	okbp
	inc	BUF_Pointer_A[0]
	jnz	okbp
	add	BUF_Pointer_A[2],4096
	cmp	BUF_Pointer_A[2],BUF0
	jb	okbp
	
	@EXIT

okbp:	les	di,dword ptr BUF_Pointer_A
	mov	al,byte ptr es:[di]
	and	al,ByteAnd_A
	jz	okchk
	pop	di
	pop	ax
	pop	es
	stc
	ret
okchk:	pop	di
	pop	ax
	pop	es
	clc
	ret
check_stili	endp

;-----------------------------------------------------------------------------
; GENITRA: THN KALEI TO METABLITO
;-----------------------------------------------------------------------------
genitra	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA

	cmp	Apo_Memory,0
	je	gen2
	call	forpinak2
	@POP
	ret
	
gen2:	mov	ax,stiles
	mov	dx,stiles[2]
	mov	cx,ypoloipo
	mov	bx,ypoloipo[2]

	call	piuan

	@CHANGESEGM	ds,DATAS1
	@WPRINT	31,1,tisekato
	@CHANGESEGM	ds,DATA

	cmp	cs:handletmp,0
	je	gen2_1
	
	call	fordisk2
	@POP
	ret
	
gen2_1:	@EXIT
genitra	endp

checka_stili	proc	near
	push	es
	push	ax
	push	di
	rol	ByteAnd_B,1
	cmp	ByteAnd_B,1
	jne	okbpa
	inc	BUF_Pointer_B[0]
	jnz	okbpa
	add	BUF_Pointer_B[2],4096
	cmp	BUF_Pointer_B[2],BUF0
	jb	okbp1
	
	@EXIT

okbp1:

okbpa:	les	di,dword ptr BUF_Pointer_B
	mov	al,byte ptr es:[di]
	and	al,ByteAnd_B
	jz	okchka
	pop	di
	pop	ax
	pop	es
	stc
	ret
okchka:	pop	di
	pop	ax
	pop	es
	clc
	ret
escmetr	dw	0
checka_stili	endp

epej	proc	near
	@PUSH
;************************************
	inc	word ptr cs:escmetr
	jnz	eopat1
	
	@CPLRNS
	jnc	eopat1
	cmp	al,@ESCAPE
	jne	eopat1
	call	ep_diakop
eopat1:
;************************************
	@CHANGESEGM	ds,DATA

	mov	cx,13
	xor	di,di
	xor	ax,ax
epej1:	mov	dl,Stili_A[di]
	cmp	Stili_B[di],dl
	je	idio
	inc	ax
	cmp	ax,2
	ja	epej2
idio:	inc	di
	loop	epej1

	inc	brika

	les	bx,dword ptr addressp
	mov	cx,13
	xor	di,di
bale1:	mov	al,Stili_B[di]
	mov	es:[bx],al
	inc	di
	inc	bx
	loop	bale1

	mov	ax,BUF_Pointer_B[0]
	mov	es:[bx],ax
	mov	ax,BUF_Pointer_B[2]
	mov	es:[bx+2],ax
	mov	al,ByteAnd_B
	mov	es:[bx+4],al

	mov	ax,18	;13+5
	add	addressp,ax
adt2:	@POP
	ret
	
epej2:	@POP
	ret
epej	endp

metablito	proc	near
	@PUSH

	@CHANGESEGM	ds,DATA
	call	 genitra

	cmp	brika,0
	je	fige
	jmp	check

fige:	@POP
	ret
	
check:	@STRCOPY	Stili_A,Stili_C,13

	mov	ax,offset apou
	mov	apou_p,ax
;*********************************** 1h sthlh	
	mov	ax,apou_p
	add	ax,10
	mov	apou_p1,ax

	call	find_apodosi
	
	mov	bx,apou_p
	mov	word ptr [bx],100
	mov	word ptr [bx+2],0
	mov	[bx+4],ax

	add	apou_p,700
;************************************
	mov	cx,13
	mov	si,cx
	dec	si
	mov	di,si
	shl	di,1
chk1:	push	cx
	push	di
	mov	ax,di
	shr	ax,1
	mov	cx,3
	mul	cx
	dec	ax
	mov	cs:_sim_p,ax

	mov	cx,plhresn[di]
alli1:	push	di
	mov	di,cs:_sim_p
	add	di,cx
	mov	dl,plhres_sim[di]
	pop	di
	cmp	dl,0
	jne	n003
	
	@WPRINTCH	0,0,"1"
	@EXIT
	
n003:	cmp	Stili_C[si],dl
	je	alli
	mov	Stili_A[si],dl

	mov	ax,apou_p
	add	ax,10
	mov	apou_p1,ax

	call	find_apodosi
	
	mov	bx,apou_p
	mov	[bx],si
	mov	[bx+2],dx
	mov	[bx+4],ax
	
	add	apou_p,700
	
alli:	inc	di
	loop	alli1

	mov	al,Stili_C[si]
	mov	Stili_A[si],al

	pop	di
	pop	cx
	dec	si
	sub	di,2
	loop	chk1
;****************************************
	mov	bx,offset apou
	add	bx,4
	mov	maxapod,0
	mov	dieu_max_apod,65535

alit:	mov	ax,[bx]
	cmp	ax,maxapod
	jb	alik
	mov	maxapod,ax
	mov	dieu_max_apod,bx

alik:	add	bx,700
	cmp	bx,apou_p
	jae	telos
	jmp	alit
	
telos:	mov	si,dieu_max_apod
	cmp	si,65535
	jne	brik

	@WPRINTCH	0,0,"6"
	@EXIT

brik:	sub	si,4
	mov	bx,[si]
	mov	ax,[si+2]
	cmp	ax,0
	je	oxialagi
	
	mov	Stili_C[bx],al

oxialagi:
	mov	ax,offset Stili_C
	call	save_deltio

	@INCL	stilesmet

	mov	cx,[si+4]
	add	si,10

sbis:	mov	ax,ADDRESS
	mov	es,ax
	mov	bx,[si]

	push	si
	mov	si,13
	mov	al,byte ptr es:[bx+4][si]
	les	di,dword ptr es:[bx][si]
	or	es:[di],al
	pop	si
	@DECL	ypoloipo

	add	si,2
	loop	sbis

	@POP
	ret
_sim_p	dw	0
metablito	endp

find_apodosi	proc	near
	@PUSHAX
	mov	ax,ADDRESS
	mov	es,ax
	mov	si,0

	xor	ax,ax
	mov	cx,brika

kira:	call	dialogi
	jc	all1

	inc	ax

all1:	mov	dx,18	;13+5
	add	si,dx
	loop	kira

	@POPAX
	ret
find_apodosi	endp

dialogi	proc	near
	@PUSH
	push	si
	mov	cx,13
	xor	ax,ax
	xor	bx,bx
dial1:	mov	dl,es:[si]
	cmp	Stili_A[bx],dl
	je	nai
	inc	ax
	cmp	ax,2
	jae	lauos
nai:	inc	si
	inc	bx
	loop	dial1
	
	pop	si
	mov	bx,apou_p1
	mov	[bx],si
	add	apou_p1,2

	@POP
	clc
	ret
lauos:	pop	si
	@POP
	stc
	ret
dialogi	endp

forpinak2	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA
	@CHANGESEGM	es,PINS1
	mov	addressp,0
	mov	ax,ADDRESS
	mov	addressp[2],ax
	mov	brika,0

	mov	ax,BUF1
	mov	BUF_Pointer_B[2],ax
	mov	BUF_Pointer_B[0],0
	mov	ByteAnd_B,1

	xor	di,di
	
fpin22:	cmp	byte ptr es:[di],0
	je	fp2end
	xor	bx,bx
	
	mov	cx,13
fpin21:	mov	al,byte ptr es:[di]
	cmp	al,0
	jne	n002

	@WPRINTCH	0,0,"3"
	@EXIT

n002:	mov	Stili_B[bx],al
	inc	bx
	inc	di
	loop	fpin21

	call	checka_stili
	jc	epp2
	call	epej

epp2:	cmp	di,65500
	jb	fpin22
	mov	ax,es
	add	ax,4096
	mov	es,ax
	xor	di,di
	jmp	fpin22
	
fp2end:	@POP
	ret
forpinak2	endp

save_deltio	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA
	mov	bx,ax
	mov	cx,13
	mov	di,metablp
	mov	ax,METABL
	mov	es,ax
jexa:	mov	al,[bx]
	cmp	al,0
	jne	n00

	@WPRINTCH	0,0,"4"
	@EXIT

n00:	mov	es:[di],al
	inc	bx
	inc	di
	loop	jexa
	
	mov	ax,13
	add	metablp,ax
	
	cmp	metablp,65500
	jb	nosave
	call	savebuf
	mov	metablp,0
nosave:	@POP
	ret
save_deltio	endp

savebuf	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA
	mov	ax,metablp
	mov	cs:_bytes,ax
	@CHANGESEGM	ds,METABL
	@WRITE_MEM	cs:handlestl,0,cs:_bytes
	jc	leo
	@POP
	ret
leo:	@EXIT
_bytes	dw	0
savebuf	endp

savetelos	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA
	mov	dx,26
	mov	di,metablp
	cmp	di,65474
	jb	hhj
	@EXIT
hhj:	mov	ax,METABL
	mov	es,ax
	add	metablp,dx
	mov	cx,dx
	xor	bx,bx
zerdel:	mov	byte ptr es:[di],0
	inc	di
	loop	zerdel
	call	savebuf
	@POP
	ret
savetelos	endp

Take_Stl_Disk	proc	near
	@PUSH
	call	zerobit
	@CHANGESEGM	ds,DATAS1

	@OPEN_HANDLE	filetmp,I_RW
	mov	cs:handletmp,ax

	@CHANGESEGM	ds,DATA
	mov	ax,65500
	xor	dx,dx
	mov	cx,13
	div	cx
	inc	ax
	mul	cx
	mov	cs:readbytes,ax

	mov	ax,BUF1
	mov	BUF_Pointer_A[2],ax
	mov	BUF_Pointer_A[0],0
	mov	ByteAnd_A,1

	@CHANGESEGM	ds,PINS1

dfpin12:
	@READ_MEM	cs:handletmp,0,cs:readbytes

	call	fordisk1_1
	jc	dfp1end

	jmp	dfpin12
dfp1end:
	@CLOSE_HANDLE	cs:handletmp
	@POP
	ret
Take_Stl_Disk	endp

fordisk2	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	@OPEN_HANDLE	filetmp,I_RW
	mov	cs:handletmp1,ax

	@CHANGESEGM	ds,DATA
	mov	addressp,0
	mov	ax,ADDRESS
	mov	addressp[2],ax
	mov	brika,0

	mov	ax,BUF1
	mov	BUF_Pointer_B[2],ax
	mov	BUF_Pointer_B[0],0
	mov	ByteAnd_B,1

	@CHANGESEGM	ds,PINS2

d2fpin12:
	@READ_MEM	cs:handletmp1,0,cs:readbytes

	call	fordisk2_1
	jc	d2fp1end

	jmp	d2fpin12
	
d2fp1end:
	@CLOSE_HANDLE	cs:handletmp1
	@POP
	ret
readbytes	dw	0
fordisk2	endp

fordisk1_1	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA
	@CHANGESEGM	es,PINS1
	xor	di,di

qfpin12:
	cmp	byte ptr es:[di],0
	je	qfp1end
	xor	bx,bx
	
	mov	cx,13
qfpin11:
	mov	al,byte ptr es:[di]
	cmp	al,0
	jne	qn001

	@WPRINTCH	0,0,"7"
	@EXIT

qn001:	mov	Stili_A[bx],al
	inc	bx
	inc	di
	loop	qfpin11

	call	check_stili
	jc	qepp1

	call	metablito

qepp1:	cmp	di,65500
	jb	qfpin12
	@POP
	clc
	ret
	
qfp1end: @POP
	stc
	ret
fordisk1_1	endp

fordisk2_1	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA
	@CHANGESEGM	es,PINS2
	xor	di,di
	
qfpin22: 
	cmp	byte ptr es:[di],0
	je	qfp2end
	xor	bx,bx
	
	mov	cx,13
qfpin21:
	mov	al,byte ptr es:[di]
	cmp	al,0
	jne	qn002

	@WPRINTCH	0,0,"8"
	@EXIT

qn002:	mov	Stili_B[bx],al
	inc	bx
	inc	di
	loop	qfpin21

	call	checka_stili
	jc	qepp2
	call	epej

qepp2:	cmp	di,65500
	jb	qfpin22
	@POP
	clc
	ret

qfp2end: @POP
	stc
	ret
fordisk2_1	endp

;***************************************************************************
;***************************************************************************
;***************************************************************************

Ascii_to_Buffer	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA

	mov	Apo_Memory,1

	mov	pinspoint,0
	mov	ax,PINS1
	mov	pinspoint[2],ax

	@CHANGESEGM	ds,DATAS1
	@OPEN_HANDLE	asciidisk,I_READ
	@CHANGESEGM	ds,DATA

	mov	cs:_handlef,ax
ascalo:	@READ_HANDLE	cs:_handlef,tempbuf,15
	jc	telasc

	mov	cx,13
	xor	bx,bx
asc12:	mov	al,tempbuf[bx]
	call	ascicode
	mov	Stili_A[bx],al
	inc	bx
	loop	asc12

	call	Stili_to_buffer

	jmp	ascalo

telasc:	@POP
	ret
_handlef	dw	0
Ascii_to_Buffer	endp

Stili_to_buffer	proc	near
	@PUSH
	@INCL	stiles
	cmp	Apo_Memory,0
	je	nopink
	call	Stili_to_Memory
	@POP
	ret

nopink:	cmp	cs:handletmp,0
	je	nodisk
	call	Stili_to_Disk
nodisk:	@POP
	ret
Stili_to_buffer	endp

ascicode	proc	near
	cmp	al,3
	ja	noal3
	ret
noal3:	cmp	al,"1"
	jne	noal1
	mov	al,1
	ret
noal1:	cmp	al,"X"
	jne	noalx
	mov	al,2
	ret
noalx:	cmp	al,"2"
	jne	noal2
	mov	al,3
	ret
noal2:	@EXIT		;;;;;; E X I T
	mov	al,0
	ret
ascicode	endp

Stili_to_Memory	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA
	mov	cx,13
	xor	bx,bx
	les	di,dword ptr pinspoint
alpin:	mov	al,Stili_A[bx]
	cmp	al,0
	jne	n007

	@WPRINTCH	0,0,"5"
	@EXIT

n007:	mov	byte ptr es:[di],al
	inc	bx
	inc	di
	loop	alpin

	mov	byte ptr es:[di],0
	mov	pinspoint,di
	cmp	di,65500
	jb	sep1
	add	pinspoint[2],4096
	mov	pinspoint,0
	mov	ax,PINS2
	cmp	pinspoint[2],ax
	jbe	sep1
;------------------------------------- Den xoraei sti Mnimi
	@SETWIND	wargo
	@SELECTWIND	wargo
	mov	Apo_Memory,0
	@WPRINT	4,1,argo
	call	Memory_to_Disk
;-------------------------------------
sep1:	@POP
	ret
Stili_to_Memory	endp

Stili_to_Disk	proc	near
	@PUSH
	@CHANGESEGM	ds,DATA
	@WRITE_HANDLE	cs:handletmp,Stili_A,13
	jc	errdsk
	@POP
	ret
errdsk:	@CLOSE_HANDLE	cs:handletmp
	mov	cs:handletmp,0
	@POP
	ret
Stili_to_Disk	endp

Memory_to_Disk	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	@CREATE_HANDLE	filetmp,0
	mov	cs:handletmp,ax
	@CHANGESEGM	ds,DATA
	@CHANGESEGM	es,PINS1
	xor	di,di

sfpin12:
	cmp	byte ptr es:[di],0
	jne	nopsf
	jmp	sfp1end
nopsf:	xor	bx,bx

	mov	cx,13
sfpin11:
	mov	al,byte ptr es:[di]
	cmp	al,3
	ja	sn002
	cmp	al,0
	jne	sn001
sn002:	@WPRINTCH	0,0,"7"
	@CLOSE_HANDLE	cs:handletmp
	@EXIT

sn001:	mov	Stili_D[bx],al
	inc	bx
	inc	di
	loop	sfpin11

	@WRITE_HANDLE	cs:handletmp,Stili_D,13
	jnc	exixoro
	@CLOSE_HANDLE	cs:handletmp
	mov	cs:handletmp,0
	@POP
	ret

exixoro:
	cmp	di,65500
	jae	nopsf1
	jmp	sfpin12
nopsf1:	mov	ax,es
	add	ax,4096
	mov	es,ax
	xor	di,di
	mov	dx,PINS2
	cmp	ax,dx
	ja	sfp1end
	jmp	sfpin12

sfp1end:
	@POP
	ret
Memory_to_Disk	endp

zerobit	proc	near
	@PUSH
	@CHANGESEGM	ds,BUF1
	mov	cx,32768
	xor	bx,bx
	xor	ax,ax
buf1c:	mov	word ptr [bx],ax
	inc	bx
	inc	bx
	loop	buf1c
	@CHANGESEGM	ds,BUF2
	mov	cx,32768
	xor	bx,bx
	xor	ax,ax
buf2c:	mov	word ptr [bx],ax
	inc	bx
	inc	bx
	loop	buf2c
	@CHANGESEGM	ds,BUF3
	mov	cx,32768
	xor	bx,bx
	xor	ax,ax
buf3c:	mov	word ptr [bx],ax
	inc	bx
	inc	bx
	loop	buf3c
	@POP
	ret
zerobit	endp

code	ends
	end
