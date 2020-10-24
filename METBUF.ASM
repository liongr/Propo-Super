
INCLUDE	globals.inc

stac	segment	stack
	dw	1000 dup(?)
stac	ends

DATAS1	segment	public
		dw	0,0
def_disk_file	db	0
menum	label	byte
IFDEF	SUPERNORMAL
	db	" NOR"
ENDIF
IFDEF	ALLTO1
	db	" 111"
ENDIF
IFDEF	ALLTO2
	db	" 222"
ENDIF
IFDEF	ALLTOX
	db	" XXX"
ENDIF
IFDEF	SUPER2
	db	" 2X1"
ENDIF
IFDEF	SUPER3
	db	" 21X"
ENDIF
IFDEF	SUPER4
	db	" X21"
ENDIF
IFDEF	SUPER5
	db	" X12"
ENDIF
IFDEF	SUPER6
	db	" 12X"
ENDIF
IFDEF	SUPER7
	db	" XX2"
ENDIF
IFDEF	SUPER8
	db	" 22X"
ENDIF
IFDEF	SUPER9
	db	" 221"
ENDIF
IFDEF	SUPER10
	db	" X22"
ENDIF
IFDEF	SUPER11
	db	" 212"
ENDIF
IFDEF	SUPER12
	db	" 122"
ENDIF
IFDEF	SUPER13
	db	" XX1"
ENDIF
	db	"    SUPER MET (c)1997-2013 TZORTZAKIS DIMITRIS & PAPADOPOULOS LEONIDAS      ",0
genesis	db	"                          Email: leonpap@gmail.com                                 ",0

asciidisk 	db	"\ascii\"
asciiname 	db	20 dup (0)
asciidir	db	"\ascii\*.TLK",0
out_asciidisk	db	"\ascii\"
out_asciiname 	db	20 dup (0)

msave_1	db	0
msave_2	db	0
mload	db	0
asciiload db	"LOAD ASCII",0
mexit	db	0
mneosys	db	0
mprosu	db	0
msbisim	db	0
mektor	db	0

filestl	db	"C:STILES0.OML",0
filetmp	db	"C:SUPER.TMP",0

superdir	db	"\SUPER",0

editbuf		db	55 dup(" ")
plhresbuf	db	55 dup(" ")
		db	100 dup(0)	;;; if del error?

strbuf	db	81 dup(0)

stand		db	13 dup(3 dup(0))
buf24_1		db	160 dup(0)
buf24_2		db	160 dup(0)
deltioscr	db	600 dup(" ")
deltioplr	db	13 dup(4 dup(0))
deltioscr1	db	600 dup(" ")
deltioplr1	db	13 dup(4 dup(0))
in_stili	db	13 dup(0),13,10
stili_ascii	db	13 dup(0)
plir_stl	dw	0,0
syst_stl	dw	0,0
deltio_num	dw	0,0
stil_or		dw	0,0
num1		db	11 dup(0)
num2		db	11 dup(0)
num3		db	11 dup(0)
tisekato	db	11 dup(0)
gentip		db	10 dup(0)
patat		db	"          PRESS A KEY     ",0
pata_taf	db	"        END .. PRESS 'T'  ",0
ejarxis		dw	0
myparx1	db	"THERE IS FILE WITH THE SAME NAME",0
myparx2	db	"DELETE IT?",0
DATAS1	ENDS

DATA	segment
plhresn		dw	15 dup(0)
plhres_sim	db	13 dup(3 dup(0))
Stili_A		db	13 dup(0),0
Stili_B		db	13 dup(0)
Stili_C		db	13 dup(0),0
Stili_D		db	13 dup(0),0
ByteAnd_A	db	0
BUF_Pointer_A	dw	0,0
ByteAnd_B	db	0
BUF_Pointer_B	dw	0,0
brika		dw	0
addressp	dw	0,0
maxapod		dw	0
min5		dw	0
dieu_max_apod	dw	0
ypoloipo	dw	0,0
xxx		db	0
yyy		db	0
metablp		dw	0
pentar		dw	0
posa		dw	0
stiles		dw	0,0
stilesmet	dw	0,0
stilesmsg	db	80 dup(0)
Apo_Memory	dw	0
pinspoint	dw	0,0
argo		db	"WAIT A BIT MORE PLEASE...",0
apou_p		dw	0
apou_p1		dw	0
apou		db	30000 dup(0)
tempbuf		db	50 dup(0)
DATA	ends

WINDOWS	SEGMENT	PUBLIC
wmetrhma db	4,30,3,36,5,70h,2
	db	0
	db	"       K O L O N E :",0
	db	0
	db	"                 % :",0
	db	0

	
wsaveascii	db	9,30,14,36,5,70h,2
	db	"        SAVE ASCII",0
	db	0
	db	"      F I L E NAME :",0
	db	0
	db	0

wplrascii	db	1,10,2,12,18,70h,1
	db	" FULL ASCII",0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

wmetrv	db	13,4,26,17,3,70h,2
	db	0
	db	"   WORKING...",0
	db	0

wtaf	db	17,1,22,23,1,70h,2
	db	"   END .. PRESS 'T'  ",0
	
keno	db	18,1,2,3,4,5,6
	db	24 dup(0)

wargo	db	19,29,19,38,1,70h,2
	db	0

wload_oml db	20,25,5,25,4,70h,2
	db	0	
	db	"      LOAD  ASCII",0
	db	"      PLEASE WAIT",0
	db	0

wdiakopi db	21,20,12,30,4,07h,2
	db	0
	db	"      TO STOP WORKING",0
	db	"          PRESS '’'",0
	db	0
WINDOWS	ENDS

CODE	segment	public
diakopi		dw	0
handlestl	dw	0
old_select	dw	0
handletmp	dw	0
handletmp1	dw	0
CODE	ends

METABL	segment
	db	65535 dup(0)
METABL	ends

ADDRESS	segment	public
adres	db	65535 dup(0)
ADDRESS	ends

PINS1	segment	public
	db	65535 dup(0)
PINS1	ends

PINS2	segment	public
	db	65535 dup(0)
PINS2	ends

BUF1	segment	public
	db	65535 dup(0)
BUF1	ends

BUF2	segment	public
	db	65535 dup(0)
BUF2	ends

BUF3	segment	public
	db	65535 dup(0)
BUF3	ends

BUF0	segment	public
	db	0 
BUF0	ends

end
