;******************
;ALLTO2 = 1
;ALLTOX = 1
;ALLTO1 = 1

;SUPERNORMAL = 1

;SUPER0 = 1
;SUPER1 = 1
;SUPER2 = 1
;SUPER3 = 1
;SUPER4 = 1
;SUPER5 = 1
;SUPER6 = 1
;SUPER7 = 1
;SUPER8 = 1
;SUPER9 = 1
;SUPER10 = 1
;SUPER11 = 1
;SUPER12 = 1
SUPER13 = 1

;******************

@WINDOWS = WINDOWS

INCLUDE	mylib.inc
INCLUDE	keys.inc
INCLUDE	sdir.inc
INCLUDE	snaioxi.inc

DATAS1	SEGMENT	PUBLIC
global	def_disk_file:byte
global	superdir:byte
global	pejefores:word
global	praktor:byte
global	emfasi:byte
global	double_strike:byte
global	ektaktos:byte
global	pio_prn:word
global	protia_prn:word
global	ektip_axb:byte
global	ektipotes_axb:word
global	aytomato_axb:word
global	anamoni_axb:word
global	riumisi_axb:word
global	emfasi_axb:word
global	double_str_axb:word
global	apostasi_axb:word
global	line_feed_axb:word
global	prchar_axb:word
global	tiposekt_axb:word
global	bad_sector:word
global	agones:byte
global	plhresbuf:byte:55
global	basikesbuf:byte:550
global	omilos:word
global	omiltmp:word
global	menupin:byte
global	menum:byte
global	oroi_oria:word
global	omiloi:byte:13
global	ues_omil:word
global	uesom_point:word
global	tipos_omil:byte
global	epilogi:word
global	mload:byte
global	asciiload:byte
global	mexit:byte
global	msave_1:byte
global	msave_2:byte
global	mneosys:byte
global	mprosu:byte
global	msbisim:byte
global	mektor:byte
global	eduesi:byte
global	scrattr:byte
global	editbuf:byte:55
global	edbufi:word
global	scrpou:byte
global	strbuf:byte:81
global	scrmsg:byte
global	genesis:byte
global	edaepl:byte
global	pliktro:word
global	edit0:byte
global	or_msg:byte
global	filedisk:byte
global	filename:byte:20
global	directory:byte
global	asciidisk:byte
global	out_asciidisk:byte
global	out_asciiname:byte
global	asciiname:byte:20
global	asciidir:byte
global	metraAscii:word
global	filestl:byte
global	filetmp:byte
global	anastl:word
global	superdir:byte
global	in_stili:byte
global	stili_ascii:byte
global	deltioscr:byte
global	deltioscr1:byte
global	plir_stl:word
global	deltioplr:byte
global	deltioplr1:byte
global	syst_stl:word
global	deltio_num:word
global	stil_or:word
global	num1:byte
global	num2:byte
global	num3:byte
global	tisekato:byte
global	gentip:byte
global	draxmes:word
global	draxmespropo:word
global	pindial:byte
global	nikitria:byte
global	patat:byte
global	pata_taf:byte
global	mdelm:byte
global	mdelsys:byte
global	ejarxis:word
global	myparx1:byte
global	myparx2:byte
global	paper:byte
global	riums:byte
global	dstrk:byte
global	lptfile:byte
global	lptmax:word
global	lpt_number:word
global	lptnames:byte
global	msg_n_o:byte
global	msg_o_n:byte
global	inffile:byte
global	riumisi:byte
global	apostasi:word
global	dstrike:byte
global	dtime:word
global	@lpt:byte
global	lptstart:word
global	names1:byte
global	names2:byte
global	prgname:byte
global	select_12pitch:byte
global	select_10pitch:byte
global	select_linefeed:byte
global	send_cr:byte
global	paper_out_on:byte
global	paper_out_off:byte
global	grp314:byte
global	prchar:byte
global	grp1:byte
global	grp2:byte
global	grp3:byte
global	grp4:byte
global	grp4_1:byte
global	grp4_2:byte
global	grp8:byte
global	tabs:byte
global	periuor:byte
global	grp41:byte
global	grp5:byte
global	grp7:byte
global	grp6:byte
global	line_feed:byte
global	dlplr:byte
global	buf24_1:byte
global	buf24_2:byte
global	stand:byte
global	cprgt:byte
global	m_ektaktos:byte
DATAS1	ENDS

WINDOWS	SEGMENT	PUBLIC
global	wload_oml:byte
global	wcright:byte
global	wagones:byte
global	woroi:byte
global	wmetrhma:byte
global	wdeltio:byte
global	wdelti:byte
global	wepej:byte
global	wepejascii:byte
global	warxeia:byte
global	wsave:byte
global	wsaveascii:byte
global	wdial1:byte
global	wdial2:byte
global	wnikitr:byte
global	wplrascii:byte
global	wmetrv:byte
global	wektip:byte
global	wdiakopi:byte
global	wpane:byte
global	wnames:byte
global	wtaf:byte
global	keno:byte
global	tstcpr1:byte
global	tstcpr2:byte
global	wprakt:byte
global	wargo:byte
global	wsuper13:byte
global	wdialsuper13:byte
WINDOWS	ENDS

CODE	SEGMENT	PUBLIC
global	print_stack:word
global	janametra:word
global	handletmp:word
global	handletmp1:word
global	old_select:word
global	chk_om:proc
global	find_stl_plir:proc
global	plr2sim:proc
global	piuan:proc
global	load_bad:proc
global	posoi_om:proc
global	for_klidi:proc
global	load_inf:proc
global	save_inf:proc
global	omilos_on:proc
global	omilos_off:proc
global	startme:proc
global	omiloi_met:proc
global	ins_agones:proc
global	basikes:proc
global	ejodos:proc
global	oroi:proc
global	eperg:proc
global	arxeia:proc
global	copyright:proc
global	clearvar:proc
global	eis_filename:proc
global	s_save:proc
global	s_load:proc
global	s_neo:proc
global	s_delete:proc
global	s_disk:proc
global	telos_erg:proc
global	plhres:proc
global	screen:proc
global	Make_Super_Met:proc
global	handlestl:word
global	menu_arxia:proc
global	scr_all:proc
global	diakopi:word
global	ep_diakop:proc
global	del_tmpom:proc
global	bas2gen:proc
CODE	ENDS

DATA	segment
global	plhresn:word
global	plhres_sim:byte:39
global	Stili_A:byte
global	Stili_B:byte
global	Stili_C:byte
global	Stili_D:byte
global	ByteAnd_A:byte
global	ByteAnd_B:byte
global	BUF_Pointer_A:word
global	BUF_Pointer_B:word
global	brika:word
global	addressp:word
global	apou_p:word
global	apou_p1:word
global	apou:byte
global	maxapod:word
global	min5:word
global	dieu_max_apod:word
global	ypoloipo:word
global	basikes_s:word
global	xxx:byte
global	yyy:byte
global	metablp:word
global	pentar:word
global	oriag:word
global	bas_pin:byte:605
global	stiles:word
global	stilesmet:word
global	stilesmsg:byte
global	emfan:word
global	Apo_Memory:word
global	pinspoint:word
global	argo:byte
global	ypoloipo:word
global	tempbuf:byte
DATA	ends

METABL	segment
METABL	ends

ADDRESS	segment	public
global	adres:byte
ADDRESS	ends

PINS1	segment	public
PINS1	ends

PINS2	segment	public
PINS2	ends

MCODE	segment	public
MCODE	ends

BUF1	segment	public
BUF1	ends

BUF2	segment	public
BUF2	ends

BUF3	segment	public
BUF3	ends

BUF4	segment	public
BUF4	ends

BUF0	segment	public
BUF0	ends

ENDSEGM	segment	public
ENDSEGM	ends

