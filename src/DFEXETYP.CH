/* 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   �                                                                      �
   �                  (C) 2000 by TWT The Wonderful Team                  �
   �                                                                      �
   읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 */

#ifndef _DFEXETYPE_CH
   #define _DFEXETYPE_CH

/* 旼컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   �  쿏escription                                                        �
   쳐컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
   쿘Z쿽ld-style DOS executable                                           �
   쿙E쿥indows or OS/2 1.x segmented ("new") executable                   �
   쿗E쿥indows virtual device driver (VxD) linear executable              �
   쿗X퀆ariant of LE used in OS/2 2.x                                     �
   쿥3쿥indows WIN386.EXE file; a collection of LE files                  �
   쿛E쿥in32/Windows NT/Win32s portable executable based on Unix COFF     �
   쿏L쿓P 100LX/200LX system manager compliant executable (.EXM)          �
   쿘P쿽ld PharLap .EXP                                                   �
   쿛2쿛harLap 286 .EXP                                                   �
   쿛3쿛harLap 386 .EXP                                                   �
   읕컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 */

   #define EXE_TYPE_UNKNOWN 0
   #define EXE_TYPE_MZ      1
   #define EXE_TYPE_NE      2
   #define EXE_TYPE_LE      3
   #define EXE_TYPE_LX      4
   #define EXE_TYPE_W3      5
   #define EXE_TYPE_PE      6
   #define EXE_TYPE_DL      7
   #define EXE_TYPE_MP      8
   #define EXE_TYPE_P2      9
   #define EXE_TYPE_P3     10

#endif
