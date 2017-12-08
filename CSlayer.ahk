;==============================================================
MODIFIED=20090103
NAME1   = CALL SLAYER
;==============================================================

;==============================================================
global WM_USER               := 0x00000400
global PBM_SETMARQUEE        := WM_USER + 10
global PBM_SETSTATE          := WM_USER + 16
global PBS_MARQUEE           := 0x00000008
global PBS_SMOOTH            := 0x00000001
global PBS_VERTICAL          := 0x00000004
global PBST_NORMAL           := 0x00000001
global PBST_ERROR            := 0x00000002
global PBST_PAUSE            := 0x00000003
global STAP_ALLOW_NONCLIENT  := 0x00000001
global STAP_ALLOW_CONTROLS   := 0x00000002
global STAP_ALLOW_WEBCONTENT := 0x00000004
global WM_THEMECHANGED       := 0x0000031A

;F1=%A_scriptdir%\test55.txt
Gui,1:default
Gui,1:Font,S7 cDefault, Verdana

RF:=1

T1=30       ;column1 width
T2=120         ;column2 width
T3=100        ;column3 width
T4=60     ;column4 width
T4=40     ;column4 width

T1A:=T1
T2A:=T1+T2
T3A:=T1+T2+T3
T4A:=T1+T2+T3+T4
T5A:=T1+T2+T3+T4+T5  ;listview width
height_gui=360
a=1.618
width_gui:=(height_gui*a)



;Gui,1:Add ,  Edit,   x10  y310   w330 h20 vURLX gSEARCH1
;Gui,1:Add,Button,default x0  y0 w0   h0  gSEARCH1 ,


  ;Gui,1:Add ,  Edit,   x280  y570   w195 h20 vURLX gSEARCH2
  ;Gui,1:Add,Button,default x0  y0 w0   h0  gSEARCH2 ,
;Gui Add, Tab3, x5 y5 w720 h440, Tab 1|Tab 2
Gui, Add, Tab2,w560 h350, Main|Settings
Gui,1:Add,GroupBox,x20  y25  w520  h50,
Gui,1:Add,GroupBox,x20  y75  w520  h50,
Gui,1:Add,Button,x410  y90   w60  h25  gBACKWARD ,<<
Gui,1:Add,Button,x470  y90   w60  h25  gFORWARD  ,>>
Gui,1:Add,Button,x25   y90   w60 h25  gCALL  ,Call
Gui,1:Add,Button,x85   y90   w60 h25  gMUTE  ,Mute
Gui,1:Add,Button,x145   y90  w60 h25  gEND  ,End
Gui,1:Add,Button,x220  y90  w60  h25  gAUTO  ,Start
Gui,1:Add,Button,x280  y90  w60  h25  gSTOP  ,Stop
Gui,1:Add,Button,x340  y90  w60  h25  gPAUSE  ,Pause
l_height = 150 ;-(%height_gui%*0.5)
l_width = 520 ;(%width_gui%*0.95)
Gui,1:Add, ListView,x20 y140 h%l_height% w%l_width% grid +hscroll nosorthdr altsubmit vMLV1A gMLV1B, #|NAME|PHONE1|PHONE2|PHONE3
LV_ModifyCol(1,T1)
LV_ModifyCol(2,T2)
LV_ModifyCol(3,T3)
LV_ModifyCol(4,T4)
LV_ModifyCol(5,T5)
LV_ModifyCol(6,T6)

Gui,1:Add ,  Text,   x30  y40  w100 h25 vJG_NAME , Name
Gui,1:Add ,  Text,   x140  y40  w100 h25 vJG_PHONE1, Phone1
Gui,1:Add ,  Text,   x250  y40  w100 h25 vJG_PHONE2, Phone2
Gui,1:Add ,  Text,   x360  y40  w100 h25 vJG_PHONE3, Phone3
Gui,1:Add ,  Text,   x470  y45  w50 h25 vJG_NUM ,0 

Gui,1:Add ,  Text,   x80  y325  w50 h25 vLog ,Unk0wn
Gui,1:Add ,  Text,   x30  y325  w50 h25  ,Status:
Gui,1:Add ,  Text,   x380  y300  w100 h25 , Current Loop:
Gui,1:Add ,  Text,   x480  y300  w50 h25 vLoopCounter , 0
Gui,1:Add ,  Text,   x380  y325  w100 h25 ,Timer:
Gui,1:Add ,  Text,   x480  y325  w50 h25 vTimer ,0

gosub,SB

Gui, Tab, 2
Gui,1:Add ,  Text,   x30  y40  w100 h25 ,Number of Loops
Gui,1:Add ,  edit,   x130  y40  w50 h25 vLoops ,50

Gui,1:Add ,  Text,   x30  y80  w100 h25 ,Mute Timer
Gui,1:Add ,  edit,   x130  y80  w50 h25 vMUTEPAUSE,7500

Gui,1:Add ,  Text,   x30  y120  w100 h25 ,Stop Time 1
Gui,1:Add ,  edit,   x130  y120  w50 h25 vSTOPPAUSE1,35000

Gui,1:Add ,  Text,   x30  y160  w100 h25 ,Stop Time 2
Gui,1:Add ,  edit,   x130  y160  w50 h25 vSTOPPAUSE2,57000

Gui,1:Add ,  Text,   x30  y200  w100 h25 ,Next Time 1
Gui,1:Add ,  edit,   x130  y200  w50 h25 vNEXTPAUSE,25000

Gui,1:Add ,  Text,   x30  y240  w100 h25 ,Next Time 2
Gui,1:Add ,  edit,   x130  y240  w50 h25 vNEXTPAUSE2,35000

Gui,1:Add ,  Text,   x30  y280  w100 h25 Choose1 ,Protocol
Gui,1:Add ,  DropDownList,   x130  y280  w50 h50 vProtocol,tel:||sip:

Gui,1:Add,Button,x325   y165  w150 h25  gLOAD  ,Import
;Gui,1:Add,Button,x150  y220  w50  h25  gSETS  ,Sets
;;Gui,1:Add,Button,x15   y195  w150  h25  gJG_GET  ,Get




;Gui,1:Add ,  Text,   x350  y30  w50 h25 vLog ,Log Area
;;Gui,1:Add ,  Edit,   x500  y140  w150 h25 vFileLocation ,AFileLocation


;Gui,1:Add ,  Radio,   x25  y220  w50 h25 vRADIO, Jabber
;Gui,1:Add ,  Radio,   x25  y240  w50 h25 vRADIO2, Cisco Any Connect



;Gui, Add, Progress, x210 y230 w500 h20, 50

; ------------------------------------------------------------------------------------------------------
Gui, Add, Progress,  x200 y250 w500 h20, %loops%
;DllCall("User32.dll\SendMessage", "Ptr", MARQ1, "Int", PBM_SETMARQUEE, "Ptr", 1, "Ptr", %counter%)





GuiControl,1:Text,TOT1,%GC%           ;show total
GuiControl,1:Text,vJG_NUM,%RF%           ;show position
GuiControl,1:Text,vJG_NAME,%RF2%           ;show position
GuiControl,1:Text,FileLocation,%File%           ;show position
Gui,1:Show, x2 y0 w%width_gui% h%height_gui%,CALL SLAYER

return
;-------------------------------

Radio:

return

Sets:


return

SB:
Gui,1:ListView,MLV1A
LV_Delete()
I=0
Loop,read,C:\Users\JGrijalva\Desktop\EX4.csv
{
stringsplit,C,A_LoopReadLine,`,,
 I++
  ;Lv_Add("", A_LoopFileName,A_LoopFileSizeKB,A_LoopFileTimeModified,A_LoopFileTimeCreated, A_LoopFileTimeAccessed,A_LoopFileAttrib, A_LoopFileFullPath)
  Lv_Add("", I,C1,C2,C3,C4,C5)
	
}

  GC:=LV_GetCount()
  LV_ModifyCol(3,"integer")
  LV_ModifyCol(4,"integer")
  LV_Modify(LV_GetCount(), "Vis")
return

/*
LV_Delete()
  loop,read,%F1%
   {
  stringsplit,C,A_LoopReadLine,`;,
  LV_Add("",C1,C2,C3)
   }
return
*/

;=================================================


;================== FORWARD =======================
FORWARD:
Gui,1:submit,nohide
Gui,1: ListView,MLV1A

;SoundPlay, Nonexistent.avi

      if (RF=(GC))
          {
          RF:=(GC)
          LV_GetText(C2,RF,2)
         ; SoundPlay,%C2%
          msgbox,,,PLAYS LAST,2
          return
}

LV_Modify(RF, "-Select -Focus")
RF:=(RF+1)
LV_Modify(RF, "+Select +Focus")

LV_GetText(C1,RF,1)
GuiControl,1:Text,JG_NUM,%RF%

LV_GetText(C1,RF,2) ;*[CALL SLAYER v1.0]
GuiControl,1:Text,JG_NAME,%C1%

LV_GetText(C2,RF,3)
GuiControl,1:Text,JG_PHONE1,%C2%

LV_GetText(C3,RF,4)
GuiControl,1:Text,JG_PHONE2,%C3%

LV_GetText(C4,RF,5)
GuiControl,1:Text,JG_PHONE3,%C4%
;LV_GetText(C4,RF,5)
;GuiControl,1:Text,vJG_NUM,%C6%
	    ;*[read]
        ;SoundPlay,%C2%

return
;===================================================




;================== BACKWARD =======================
BACKWARD:
Gui,1:submit,nohide
Gui,1: ListView,MLV1A
 ;SoundPlay, Nonexistent.avi
if RF=1
{
         LV_Modify(1, "+Select +Focus")
         LV_GetText(C2,RF,2)
         ; SoundPlay,%C2%
          msgbox,,,PLAYS FIRST,2
          return
}

LV_Modify(RF, "-Select -Focus")
RF:=(RF-1)
LV_Modify(RF, "+Select +Focus")

LV_GetText(C1,RF,1)
GuiControl,1:Text,JG_NUM,%RF%

LV_GetText(C1,RF,2)
GuiControl,1:Text,JG_NAME,%C1%

LV_GetText(C2,RF,3)
GuiControl,1:Text,JG_PHONE1,%C2%

LV_GetText(C3,RF,4)
GuiControl,1:Text,JG_PHONE2,%C3%

LV_GetText(C4,RF,5)
GuiControl,1:Text,JG_PHONE3,%C4%
;LV_GetText(C4,RF,4)
;GuiControl,1:Text,POS3,%C6%
        ;SoundPlay,%C2%

return
;===================================================

;================== CALL =======================
CALL:
Gui,1:submit,nohide
Gui,1: ListView,MLV1A

LV_GetText(C3,RF,3)
run,%Protocol%%C3%
Sleep,333
Send,{Enter}
return

;===================================================

;================== LOAD =======================
LOAD:
Gui,1:submit,nohide
Gui,1: ListView,MLV1A
FileSelectFile, SelectedFile, 3, , Open a file, Text Documents (*.csv)
if SelectedFile =
	MsgBox, The user didn't select anything.
else
	File = `n%SelectedFile%
MsgBox, `n%SelectedFile%

Gui,1:ListView,MLV1A
LV_Delete()
I=0
Loop,read, %SelectedFile%
{
stringsplit,C,A_LoopReadLine,`,,
 I++
  ;Lv_Add("", A_LoopFileName,A_LoopFileSizeKB,A_LoopFileTimeModified,A_LoopFileTimeCreated, A_LoopFileTimeAccessed,A_LoopFileAttrib, A_LoopFileFullPath)
  Lv_Add("", I,C1,C2,C3,C4,C5,C6)
	
}

GC:=LV_GetCount()
LV_ModifyCol(3,"integer")
LV_ModifyCol(4,"integer")
LV_Modify(LV_GetCount(), "Vis")
;LV_GetText(C3,RF,3)
;run,tel:%C3%
return

;===================================================

;================== MUTE =======================
MUTE:
Gui,1:submit,nohide
Gui,1: ListView,MLV1A
WinActivate, ahk_class wcl_manager1
Send,^{Down}

;FileSelectFile, fileLocation
;LV_GetText(C3,RF,3)
;run,tel:%C3%
return

;===================================================

;================== END =======================
END:
Gui,1:submit,nohide
Gui,1: ListView,MLV1A
WinActivate, ahk_class wcl_manager1
Sleep, 333
Send, ^k
;FileSelectFile, fileLocation
;LV_GetText(C3,RF,3)
;run,tel:%C3%
return

;===================================================

;================== AUTO =======================
AUTO:
Gui,1:submit,nohide
Gui,1: ListView,MLV1A
counter:=1
b=0
StartTimer()
GuiControl,1:Text,Log,Starting...
loop %loops%
{
	if(b=1)
	{
		b = 0
		Break
	}
	
	LV_GetText(C3,RF,3)
	run,%Protocol%%C3%
	Sleep,333
	WinActivate, ahk_class wcl_manager1
	;Send,{Enter}
	Sleep, 6500
	GuiControl,1:Text,Log,Muting...
	WinActivate, ahk_class wcl_manager1
	Send,^{Down}
	GuiControl,1:Text,Log,Calling...
	RandSleep(35000,57000)
	WinActivate, ahk_class wcl_manager1
	Send,^k
	WinActivate, CALL SLAYER ahk_class AutoHotkeyGUI
	Sleep, 333
	ControlClick, Button3, CALL SLAYER ahk_class AutoHotkeyGUI
	Sleep, 333
	GuiControl,1:Text,Log,Waiting...
	RandSleep(10000,15000)
	counter+=1
	GuiControl,1:Text,LoopCounter,%counter%
	GuiControl,, MyProgress, %counter%
}
StopTimer()


return




JG_GET:
myText:= WBGet()
MsgBox, `n'%myText%


return

STOP:
GuiControl,1:Text,Log,Stopped...
Exit
return

PAUSE:
GuiControl,1:Text,Log,Paused..
Pause
return

;===================================================

;---- SEARCH first example ---------------
SEARCH1:
Gui,1:submit,nohide
if URLX=
	gosub,SB
RF:=LV_GetNext("F")
RF:=1
Loop % LV_GetCount()
{
	LV_GetText(C1,RF,1)
	LV_GetText(C2,RF,2)
	LV_GetText(C3,RF,3)
	LV_GetText(C4,RF,4)
	LV_GetText(C5,RF,5)
	LV_GetText(C6,RF,6)
	CX=%C1% %C2% %C3% %C4% %C5% %C6% 
	ifinstring,CX,%URLX%
	{
		RF:=(RF+1)
		continue
	}
	LV_Delete(RF)
}
 return


;--- second example reads a file ----
SEARCH2:
Gui,1:submit,nohide
LV_Delete()
loop,read,%F1%
{
	LR=%A_loopreadline%
	stringsplit,C,LR,`;,
	CX=%C1% %C2% %C3% %C4% %C5% %C6%
	ifinstring,CX,%URLX%
	{
		LV_Add("",C1,C2,C3,C4,C5,C6)
	}
}
return

;-----------------------------------------------
MLV1B:
Gui,1:Submit,nohide
Gui,1:ListView,MLV1A

    RN:=LV_GetNext("C")
    RF:=LV_GetNext("F")
    GC:=LV_GetCount()

if A_GuiEvent=normal
{
	LV_GetText(C3,A_EventInfo,3)
	GuiControl,1:Text,vJG_NAME,%C3%
	
	ToolTip You double-clicked row number %A_EventInfo%. Text: "%C3%"
	GuiControl,1:Text,vJG_NUM,%RF%
	
	LV_GetText(C1,RF,1)
	GuiControl,1:Text,JG_NUM,%RF%
	
	LV_GetText(C1,RF,2) ;*[CALL SLAYER v1.0]
	GuiControl,1:Text,JG_NAME,%C1%
	
	LV_GetText(C2,RF,3)
	GuiControl,1:Text,JG_PHONE1,%C2%
	
	LV_GetText(C3,RF,4)
	GuiControl,1:Text,JG_PHONE2,%C3%
	
	LV_GetText(C4,RF,5)
	GuiControl,1:Text,JG_PHONE3,%C4%
   ;soundplay,%C2%
	return
}
return
;================================================

RandSleep(x,y) {
	Random, rand, %x%, %y%
	Sleep %rand%
}

StartTimer(){
	SetTimer,AUTO,On
}
StopTimer(){
	SetTimer,AUTO,Off
}




WBGet(WinTitle="ahk_class IEFrame", Svr#=1) { ; based on ComObjQuery docs
	static	msg := DllCall("RegisterWindowMessage", "str", "WM_HTML_GETOBJECT")
	,	IID := "{0002DF05-0000-0000-C000-000000000046}" ; IID_IWebBrowserApp
;	,	IID := "{332C4427-26CB-11D0-B483-00C04FD90119}" ; IID_IHTMLWindow2
	SendMessage msg, 0, 0, Internet Explorer_Server%Svr#%, %WinTitle%
	if (ErrorLevel != "FAIL") {
		lResult:=ErrorLevel, VarSetCapacity(GUID,16,0)
		if DllCall("ole32\CLSIDFromString", "wstr","{332C4425-26CB-11D0-B483-00C04FD90119}", "ptr",&GUID) >= 0 {
			DllCall("oleacc\ObjectFromLresult", "ptr",lResult, "ptr",&GUID, "ptr",0, "ptr*",pdoc)
			return ComObj(9,ComObjQuery(pdoc,IID,IID),1), ObjRelease(pdoc)
		}
	}
}

Guiclose:
exitapp

