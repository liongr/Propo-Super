
INCLUDE	globals.inc

code	segment	public

	assume	cs:code

main	proc	far
	@STARTPRG
	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,MCODE
	@SETWINSEGM	WINDOWS
	@FILLSCR	"±",07H
	@LOCATE	0,0

	@CLRCURS
	@USERW	0,0

	@SELECTWI	0
	@FILLSCR	"±",07H
	@WPRINT	0,0,menum
	@WPRINT	0,24,genesis

	call	clearvar

	call	import_stl
        jc      is_eror

	call	find_plr_ascii
;----------------------------------------
       	call	metrhmasthlvn
;----------------------------------------

       	call	save_ascii

is_eror:
	@FILLSCR	" ",07H
	@LOCATE	0,0
	@ENDPRG
	retf
main	endp

ep_diakop	proc	near
	@PUSH
	@BELL
	@SETWIND	wdiakopi
	@WAIT	100
	pushf
	@DELWIND	wdiakopi
	popf
	jnc	denpa
	@UPPERAX
	cmp	al,"T"
	je	isdiak
denpa:	@POP
	ret
isdiak:	@DELWIND	wargo
	mov	cs:is_diakop,1
	@CLOSE_HANDLE	cs:handletmp
	@CLOSE_HANDLE	cs:handletmp1
	@EXIT
	mov	cs:handletmp,0
	mov	sp,cs:diakopi
	@POP
	ret
is_diakop	dw	0
ep_diakop	endp

clearvar proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@ZEROBBUF	plhresbuf,55," "
	@CHANGESEGM	ds,DATA
	@ZEROBBUF	plhresn,13
	@ZEROBBUF	plhres_sim,39
	@POP
	ret
clearvar endp

metrhmasthlvn	proc	near
	@PUSH
	@TAKEWIND
	push	ax
	@SETWIND	wmetrhma
	@SELECTWIND	wmetrhma

	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATA

	call	tajin

	@LTOA	syst_stl,syst_stl[2],strbuf
	@WPRINT	22,2,strbuf
	
	cmp	syst_stl,0
	jne	exostl1
	cmp	syst_stl[2],0
	jne	exostl1
	mov	tisekato[0],"0"
	mov	tisekato[1],"0"
	mov	tisekato[2],"."
	mov	tisekato[3],"0"
	mov	tisekato[4],"0"
	jmp	gamo

exostl1:
	mov	ax,stil_or
	mov	dx,stil_or[2]
	mov	cx,syst_stl
	mov	bx,syst_stl[2]

	call	piuan

gamo:	@WPRINT	22,4,tisekato
	@WPRINTCH	29,4,"%"

	pop	dx
	@SELECTWI	dl
	@POP
	ret
metrhmasthlvn	endp

tajin	proc	near
	@PUSH
	@SETWIND	wmetrv
	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATA
	
	mov	cs:is_diakop,0
	mov	syst_stl,1
	mov	syst_stl[2],0
	mov	stil_or,1
	mov	stil_or[2],0

	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATA

	call	plr2sim

;***************************************************************
	call	change_plr 	; *DUSAN* ALLAGH SEIRAS PLIRES 
;***************************************************************

	mov	es:stiles,0
	mov	es:stiles[2],0
	mov	es:stilesmet,0
	mov	es:stilesmet[2],0
	
	@CREATE_HANDLE	filestl,0
	mov	cs:handlestl,ax

;---------------------------------------
	call	Make_Super_Met
;---------------------------------------
	
	@CLOSE_HANDLE	cs:handlestl

	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATA

	@LMULN	stil_or,es:stiles
	mov	stil_or[2],dx
	mov	stil_or,ax

	@LMULN	syst_stl,es:stilesmet
	mov	syst_stl,ax
	mov	syst_stl[2],dx
	
	mov	plir_stl,1
	mov	plir_stl[2],0

	@LMULN	syst_stl,plir_stl
	mov	syst_stl,ax
	mov	syst_stl[2],dx
	
	@LMUL	stil_or[2],stil_or,plir_stl[2],plir_stl
	mov	stil_or,ax
	mov	stil_or[2],dx
	
	@POP
	ret
tajin	endp

@S1 = al
@S2 = dl
@S3 = ah

change_plr	proc	near
IFDEF	SUPERNORMAL
	ret
ENDIF
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATA
	xor	si,si
	xor	di,di
	mov	cx,13
chang_epom:
	mov	dx,es:plhresn[si]
	cmp	dx,3
	je	is_tripli
	cmp	dx,1
	je	is_moni

is_dipli:
IFDEF	ALLTO2
	mov	es:plhres_sim[di],3
	mov	es:plhres_sim[di+1],3
	jmp	is_moni
ENDIF
IFDEF	ALLTOX
	mov	es:plhres_sim[di],2
	mov	es:plhres_sim[di+1],2
	jmp	is_moni
ENDIF
IFDEF	ALLTO1
	mov	es:plhres_sim[di],1
	mov	es:plhres_sim[di+1],1
	jmp	is_moni
ENDIF
	mov	@S1,es:plhres_sim[di]
	mov	@S2,es:plhres_sim[di+1]
	mov	es:plhres_sim[di],@S2
	mov	es:plhres_sim[di+1],@S1
	jmp	is_moni

is_tripli:
IFDEF	ALLTO2
	mov	es:plhres_sim[di],3
	mov	es:plhres_sim[di+1],3
	mov	es:plhres_sim[di+2],3
ENDIF
IFDEF	ALLTOX
	mov	es:plhres_sim[di],2
	mov	es:plhres_sim[di+1],2
	mov	es:plhres_sim[di+2],2
ENDIF
IFDEF	ALLTO1
	mov	es:plhres_sim[di],1
	mov	es:plhres_sim[di+1],1
	mov	es:plhres_sim[di+2],1
ENDIF

	mov	@S1,es:plhres_sim[di] 		 ;1 = 1
	mov	@S2,es:plhres_sim[di+1]          ;2 = X
	mov	@S3,es:plhres_sim[di+2]          ;3 = 2

IFDEF	SUPER2
	mov	es:plhres_sim[di],@S3	 	 ;3
	mov	es:plhres_sim[di+1],@S2	 	 ;2
	mov	es:plhres_sim[di+2],@S1	 	 ;1
ENDIF
IFDEF	SUPER3
	mov	es:plhres_sim[di],@S3            ;3
	mov	es:plhres_sim[di+1],@S1          ;1
	mov	es:plhres_sim[di+2],@S2          ;2
ENDIF
IFDEF	SUPER4
	mov	es:plhres_sim[di],@S2            ;2
	mov	es:plhres_sim[di+1],@S3          ;3
	mov	es:plhres_sim[di+2],@S1          ;1
ENDIF
IFDEF	SUPER5
	mov	es:plhres_sim[di],@S2            ;2
	mov	es:plhres_sim[di+1],@S1          ;1
	mov	es:plhres_sim[di+2],@S3          ;3
ENDIF
IFDEF	SUPER6
	mov	es:plhres_sim[di],@S1            ;1
	mov	es:plhres_sim[di+1],@S3          ;3
	mov	es:plhres_sim[di+2],@S2          ;2
ENDIF
IFDEF	SUPER7
	mov	es:plhres_sim[di],@S2	 	 ;2
	mov	es:plhres_sim[di+1],@S2	 	 ;2
	mov	es:plhres_sim[di+2],@S3	 	 ;3
ENDIF
IFDEF	SUPER8
	mov	es:plhres_sim[di],@S3	 	 ;3
	mov	es:plhres_sim[di+1],@S3	 	 ;3
	mov	es:plhres_sim[di+2],@S2	 	 ;2
ENDIF
IFDEF	SUPER9
	mov	es:plhres_sim[di],@S3	 	 ;3
	mov	es:plhres_sim[di+1],@S3	 	 ;3
	mov	es:plhres_sim[di+2],@S1	 	 ;1
ENDIF
IFDEF	SUPER10
	mov	es:plhres_sim[di],@S2	 	 ;2
	mov	es:plhres_sim[di+1],@S3	 	 ;3
	mov	es:plhres_sim[di+2],@S3	 	 ;3
ENDIF
IFDEF	SUPER11
	mov	es:plhres_sim[di],@S3	 	 ;3
	mov	es:plhres_sim[di+1],@S1	 	 ;1
	mov	es:plhres_sim[di+2],@S3	 	 ;3
ENDIF
IFDEF	SUPER12
	mov	es:plhres_sim[di],@S1	 	 ;1
	mov	es:plhres_sim[di+1],@S3	 	 ;3
	mov	es:plhres_sim[di+2],@S3	 	 ;3
ENDIF

is_moni:
	add	di,3
	add	si,2
	loop	chang_epom
	@POP
	ret
change_plr	endp

plr2sim	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATA

	xor	si,si
	xor	bx,bx

	mov	cx,13
plrg2:	mov	al,plhresbuf[bx]
	call	metatr
	mov	es:plhres_sim[si],al

	mov	al,plhresbuf[bx+1]
	call	metatr
	mov	es:plhres_sim[si+1],al

	mov	al,plhresbuf[bx+2]
	call	metatr
	mov	es:plhres_sim[si+2],al
	
	add	si,3
	add	bx,3
	loop	plrg2

	xor	si,si
	xor	bx,bx

	mov	cx,13
plrg3:	mov	ax,3
	cmp	plhresbuf[bx+2]," "
	jne	is_ato
	mov	ax,2
	cmp	plhresbuf[bx+1]," "
	jne	is_ato
	mov	ax,1
is_ato:	mov	es:plhresn[si],ax
	add	si,2
	add	bx,3
	loop	plrg3
	@POP
	ret
plr2sim	endp

metatr	proc	near
	cmp	al,"1"
	je	qis1
	cmp	al,"2"
	je	qis2
	cmp	al,"X"
	je	qisX
	mov	al,0
	ret
qis1:	mov	al,1
	ret
qis2:	mov	al,3
	ret
qisX:	mov	al,2
	ret
metatr	endp

metscr	proc	near
	cmp	al,1
	je	sqis1
	cmp	al,2
	je	sqisX
	cmp	al,3
	je	sqis2
	mov	al," "
	ret
sqis1:	mov	al,"1"
	ret
sqis2:	mov	al,"2"
	ret
sqisX:	mov	al,"X"
	ret
metscr	endp

piuan	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	cs:m1,cx
	mov	cs:m2,bx
	mov	cs:m3,ax
	mov	cs:m4,dx
	@LTOA10	cs:m1,cs:m2,num1
	mov	cx,8
	mov	bx,0
alo1:	mov	al,num1[bx+2]
	mov	num1[bx],al
	inc	bx
	loop	alo1
	xor	ax,ax
	mov	num1[8],"0"
	mov	num1[9],"0"
	@LTOA10	cs:m3,cs:m4,num2
diera:	@FILLSTR	num3,0,10
	call	aferesi
	jc	diert
	inc	ax
	@STRCOPY	num3,num1,10
	jmp	diera
diert:	@ITOA	tisekato,3
	mov	cx,9
	mov	bx,0
alo11:	mov	al,num1[bx+1]
	mov	num1[bx],al
	inc	bx
	loop	alo11
	xor	ax,ax
	mov	num1[9],"0"
diera1:	@FILLSTR	num3,0,10
	call	aferesi
	jc	diert1
	inc	ax
	@STRCOPY	num3,num1,10
	jmp	diera1
diert1:	mov	tisekato[3],"."
	@ITOA	tisekato[4],1
	mov	cx,9
	mov	bx,0
alo12:	mov	al,num1[bx+1]
	mov	num1[bx],al
	inc	bx
	loop	alo12
	xor	ax,ax
	mov	num1[9],"0"
diera2:	@FILLSTR	num3,0,10
	call	aferesi
	jc	diert2
	inc	ax
	@STRCOPY	num3,num1,10
	jmp	diera2
diert2:	@ITOA	tisekato[5],1
	@POP
	ret
m1	dw	0
m2	dw	0
m3	dw	0
m4	dw	0
krat	db	0
piuan	endp

aferesi	proc	near
	@PUSH
	mov	cx,10
	mov	bx,9
	mov	cs:krat,0
alon:	mov	al,num2[bx]
	sub	al,"0"
	mov	ah,num1[bx]
	sub	ah,"0"
	add	al,cs:krat
	cmp	al,ah
	ja	kra1
	mov	cs:krat,0
	jmp	ok
kra1:	add	ah,10
	mov	cs:krat,1
ok:	sub	ah,al
	add	ah,"0"
	mov	num3[bx],ah
	dec	bx
	loop	alon
	cmp	cs:krat,0
	je	oklc
	@POP
	stc
	ret
oklc:	@POP
	clc
	ret
aferesi	endp

import_stl	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@DISKDIR asciiname,asciidir,asciiload
	jc	load0
load1:	call	addascext
	cmp	asciiname,"."
	jne	load3
load0:	@POP
	stc
	ret
load3:  @POP
	clc
	ret
import_stl	endp

save_ascii	proc	near
	@PUSH
	@TAKEWIND
	push	ax
	@SETWIND	wsaveascii
okit2:	@SELECTWIND	wsaveascii
	@FILLSTR	out_asciiname," ",8
	@WINPUT	22,3,out_asciiname
	jnc	save1

save2:	@DELWIND	wsaveascii
	pop	dx
	@SELECTWI	dl
	@POP
	ret

save1:	call	addascext1
	cmp	out_asciiname,"."
	je	save2
	@TESTFILE	out_asciidisk
	jc	okit1

	mov	byte ptr strbuf,0
	@NAIOXI	34,6,strbuf,myparx1,myparx2
	jnc	okit1
	cmp	ax,0
	jne	nok2
	jmp	okit2
nok2:	@DELWIND	wsaveascii
	pop	dx
	@SELECTWI	dl
	@POP
	ret
	
okit1:	mov	cs:is_diakop,0
	mov	stili_ascii[13],13
	mov	stili_ascii[14],10
	@CREATE_HANDLE	out_asciidisk,0
	mov	cs:ascii_handle,ax
	xor	dx,dx
	@OPEN_HANDLE	filestl,I_READ
	mov	cs:handleomil,ax
alistl:	mov	in_stili,0
	@READ_HANDLE	cs:handleomil,in_stili,13
	cmp	in_stili,0
	jne	stilok
	
	jmp	figere

stilok:	mov	cx,13
	xor	bx,bx
kker1:	mov	al,in_stili[bx]
	cmp	al,1
	jne	qnoal1
	mov	al,"1"
	jmp	kker
qnoal1:	cmp	al,2
	jne	qnoal2
	mov	al,"X"
	jmp	kker
qnoal2:	cmp	al,3
	jne	qnoal3
	mov	al,"2"
	jmp	kker
qnoal3:	mov	al," "
kker:	mov	stili_ascii[bx],al
	inc	bx
	loop	kker1
	@WRITE_HANDLE	cs:ascii_handle,stili_ascii,15
	jmp	alistl

figere:	@CLOSE_HANDLE	cs:ascii_handle
	@CLOSE_HANDLE	cs:handleomil
	@DELWIND	wsaveascii
	pop	dx
	@SELECTWI	dl
	@POP
	ret
ascii_handle	dw	0
handleomil	dw	0
save_ascii	endp

addascext	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	bx,0
jana:	cmp	asciiname[bx],0
	je	endit
	cmp	asciiname[bx]," "
	je	endit
	cmp	asciiname[bx],"."
	je	endit
	inc	bx
	jmp	jana
endit:	mov	asciiname[bx],"."
	mov	asciiname[bx+1],"T"
	mov	asciiname[bx+2],"L"
	mov	asciiname[bx+3],"K"
	mov	asciiname[bx+4],0
	@POP
	ret
addascext	endp

addascext1	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	bx,0
jana1:	cmp	out_asciiname[bx],0
	je	endit1
	cmp	out_asciiname[bx]," "
	je	endit1
	cmp	out_asciiname[bx],"."
	je	endit1
	inc	bx
	jmp	jana1
endit1:	mov	out_asciiname[bx],"."
	mov	out_asciiname[bx+1],"T"
	mov	out_asciiname[bx+2],"L"
	mov	out_asciiname[bx+3],"K"
	mov	out_asciiname[bx+4],0
	@POP
	ret
addascext1	endp

find_plr_ascii	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	cs:metrl,0
	mov	cs:metrh,0
	@OPEN_HANDLE	asciidisk,I_READ
	@FILLSTR	strbuf," ",55
	@CHANGESEGM	ds,DATA

	mov	cs:handlef,ax
	@READ_HANDLE	cs:handlef,tempbuf,15
	@MOVEFP		cs:handlef,0,0,I_BEG
	mov	cs:bite,15
	cmp	tempbuf[13],10
	je	ascalo
	cmp	tempbuf[13],13
	je	ascalo
	mov	cs:bite,13
ascalo:	@READ_HANDLE	cs:handlef,tempbuf,cs:bite
	jc	telasc
	@INCL	cs:metrl
	mov	cx,13
	xor	bx,bx
	xor	di,di
	xor	si,si
	xor	ax,ax
asc12:	mov	al,tempbuf[si]
	call	ascicode
	dec	al
	mov	di,ax
	mov	dl,tempbuf[si]
	@CHANGESEGM	ds,DATAS1
	mov	strbuf[bx][di],dl
	@CHANGESEGM	ds,DATA
	inc	si
	add	bx,3
	loop	asc12
	jmp	ascalo

telasc:	@CHANGESEGM	ds,DATAS1
	@FILLSTR	plhresbuf," ",55
	mov	cx,13
	xor	bx,bx
	xor	di,di

litr3:	push	cx
	push	di
	push	bx
	mov	cx,3
litr2:	mov	dl,strbuf[bx]
	cmp	dl," "
	je	litr1
	mov	plhresbuf[di],dl
	inc	bx
	inc	di
	loop	litr2
	jmp	litr4
litr1:	inc	bx
	loop	litr2
litr4:	pop	bx
	pop	di
	pop	cx
	add	di,3
	add	bx,3
	loop	litr3
	call	plrview
	@POP
	ret
bite	dw	0
handlef	dw	0
metrl	dw	0
metrh	dw	0
_ux	db	0
find_plr_ascii	endp

plrview	proc	near
	@PUSH
	@SETWIND	wplrascii
	@SELECTWIND	wplrascii
	mov	cs:_ux,3
	xor	bx,bx
	mov	cx,13
faka:	@WPRINTCH	5,cs:_ux,plhresbuf[bx]
	@WPRINTCH	6,cs:_ux,plhresbuf[bx+1]
	@WPRINTCH	7,cs:_ux,plhresbuf[bx+2]
	add	bx,3
	inc	cs:_ux
	loop	faka
	@LTOA	cs:metrl,cs:metrh,strbuf
	@WPRINT	4,17,strbuf
	@POP
	ret
plrview	endp

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
noal2:	mov	al,0
	ret
ascicode	endp

code	ends
	end	main
