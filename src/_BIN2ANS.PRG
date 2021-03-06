
/* 北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
   Funzione bin2ans( inparam ,outparam )
   Inparam : Stringa contenete la schermata
   outparam: File ansi da scrivere
   flagcoord := .t. se si vuole visualizzare il contatore
   jjx,jjy = coordinate del contatore
   北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北 */

#include "common.ch"
* 北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
FUNCTION bin2ans( inparam ,outparam, flagcoord,jjx,jjy)
* 北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
local handle := 0,cbuff:="",char:="",col:=0,co1:=0,co2:=0
local x:=0,y:=0,MAX:=0,outbuff:="",outh:=0,lmax:=0
local oldco1:=0,oldco2:=0,newco1:="0",newco2:="0"
local check_ansi:="",is_lite:="0",waslite:="0",is_blink:="0",wasblink:="0"
local is_col1_changed:="1",is_col2_changed:="1"
/* Per ANSI.SYS questi sono i colori (che scherzi del cazzo!) */
local ansicol:= {"0",;  && Nero 
                 "4",;  && Blu 
                 "2",;  && Verde 
                 "6",;  && Azzurro 
                 "1",;  && Rosso 
                 "5",;  && Magenta 
                 "3",;  && Giallo 
                 "7"  } && Bianco 

if valtype(inparam) # "C"  /* parm 1 DEVE essere uno savescreen et simila */
   return .f.
ENDIF
IF empty(outparam)
   if "." $ inparam
      outparam := LEFT(INPARAM,AT(".",INPARAM)-1)+".ANS"
   endif
ELSE
   if !("." $ outparam)
      outparam := left( outparam , 8)+".ans"
   endif
ENDIF
outparam := Upper(outparam)
outh := fcreate( outparam )
fwrite(outh ,"[0m[2J",8) // cls
MAX := len(inparam)/160
CBUFF := SPACE(160)

LMAX := len(alltrim(str(MAX,10,0))) /// mi calcolo il n. di cifre
if flagcoord
   @ jjx,jjy say"Lines: "+space(lmax)+"/"+strtran(str(max,lmax,0)," ","0")
endif
FOR X := 1 TO MAX
    outbuff := ""
    cbuff := substr(inparam, ((x-1)*160)+1 ,160)
    for y := 1 to 160 step 2
        char  := substr(cbuff,y,1)
        col   := substr(cbuff,y+1,1)
        co1   := dfand(asc(col),15)
        co2   := int((asc(col)-co1)/16)
        newco1:= ansicol[dfand(co1,7)+1]
        newco2:= ansicol[dfand(co2,7)+1]
        is_lite := if(co1>7,"1","0")                    && � intenso ?
        is_blink :=if(co2>7,"1","0")                    && � lampeggiante?
         IF x+y == 2 /// sto processando il primo carattere, tutto default
            is_col1_changed := "1"
            is_col2_changed := "1"
            Waslite         := "0"
            wasblink        := "0"
         ELSE
            is_col1_changed := if(!(co1 == oldco1),"1","0")     && � cambiato il 1 col?
            is_col2_changed := if(!(co2 == oldco2),"1","0")     && � cambiato il 2 col?
         endif
        /* nient'altro???????? */

        check_ansi := is_col1_changed + ;
                      is_col2_changed + ;
                      is_lite         + ;
                      waslite         + ;
                      is_blink        + ;
                      wasblink

        do case
           case left(check_ansi ,2)== "00"

                outbuff += char

           case check_ansi $ "010000-010011-011100-011111"
                outbuff += "[4"+newco2+"m"+char

           case check_ansi $ "010100-010101-010001-100001-100100-100101-110001-110100-110101"
                outbuff += "[0"+if(newco1#"7",";3"+newco1,"")+if(newco2#"0",";4"+newco2,"")+"m"+char

           case check_ansi $ "011101-101001-101101-111001-111101"
                outbuff += "[0;1"+if(newco1#"7",";3"+newco1,"")+if(newco2#"0",";4"+newco2,"")+"m"+char

           case check_ansi $ "011000-011011"
                outbuff += "[1;4"+newco2+"m"+char

           case check_ansi $ "100000-101100-100011-101111"
                outbuff += "[3"+newco1+"m"+char

           case check_ansi $ "101000-101011"
                outbuff += "[1;3"+newco1+"m"+char

           case check_ansi $ "110000-110011-111100-111111"
                outbuff += "[3"+newco1+";4"+newco2+"m"+char

           case check_ansi $ "111000-111011"
                outbuff += "[1;3"+newco1+";4"+newco2+"m"+char

           /* quelli con blink sono meno probablili, lasciamoli per ultimi */
           case check_ansi $ "100010-101110"
                outbuff += "[5;3"+newco1+"m"+char

           case check_ansi == "101010"
                outbuff += "[1;5;3"+newco1+"m"+char

           case check_ansi == "010010"
                outbuff += "[5;4"+newco2+"m"+char

           case check_ansi == "011110"
                outbuff += "[0;1;5"+if(newco1#"7",";3"+newco1,"")+if(newco2#"0",";4"+newco2,"")+"m"+char

           case check_ansi $ "010110-010111-011001-100110-100111-110110-110111"
                outbuff += "[0;5"+if(newco1#"7",";3"+newco1,"")+if(newco2#"0",";4"+newco2,"")+"m"+char

           case check_ansi == "011010"
                outbuff += "[1;5;4"+newco2+"m"+char

           case check_ansi == "111010"
                outbuff += "[1;5;3"+newco1+";4"+newco2+"m"+char

           case check_ansi $ "110010-111110"
                outbuff += "[5;3"+newco1+";4"+newco2+"m"+char

        endcase


        oldco1 := co1
        oldco2 := co2
        waslite := is_lite
        wasblink:= is_blink


    next
    /* le righe vuote con sfondo nero posso tradurle in CRLF */
    if space(80) $ outbuff .and. asc(col) < 16
          outbuff := strtran(outbuff,space(80),chr(13)+chr(10))
    ENDif
    fwrite(outh ,outbuff,len(outbuff))
    if flagcoord
       @ jjx,jjy+7 say strtran(str(x,lmax,0)," ","0")
    endif
next
if co2 == 0
   if right( outbuff,1) == " "
      fseek(outh,-1,1)  // cancello l'ultimo spazio nero
                        // se no andrebbe a capo per niente
   else
      while outbuff == chr(13)+chr(10)
         fseek(outh,-2,1)  // cancello gli ultimi Crlf
                           // se no andrebbe a capo per niente
         outbuff:= "  "
         fread(outh,@outbuff,2)
         if outbuff == chr(13)+chr(10)
            fseek(outh,-2,1)
         endif
      enddo
      fwrite(outh,"")  && trick suggested by TEO : truncate file @ curr. pos
   endif
endif
fwrite(outh ,chr(27)+"[0m"+chr(27)+"[255D",10)
fclose (outh)
retu .t.
