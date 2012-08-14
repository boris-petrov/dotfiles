;****************
;*              *
;*   Mappings   *
;*              *
;****************

#Include C:\Program Files\KDE Mover-Sizer\KDE Mover-Sizer.ahk

~LAlt Up::return
~RAlt Up::return

#IfWinActive ahk_class classFoxitReader

j::Send {Down}

+j::
Loop 4
{
	Send {Down}
}
return

k::Send {Up}

+k::
Loop 4
{
	Send {Up}
}
return

l::Send {Right}
h::Send {Left}

g::
if (A_PriorHotkey <> "g" or A_TimeSincePriorHotkey > 400)
{
	; Too much time between presses, so this isn't a double-press.
	KeyWait, g
	return
}
Send {Home}
return

b::
if (A_PriorHotkey <> "g" or A_TimeSincePriorHotkey > 400)
{
	; Too much time between presses, so this isn't a double-press.
	KeyWait, b
	return
}
Send !{Left}
return

+g::Send {End}
/::Send ^f

#IfWinActive

#If WinActive("ahk_class icoicq") or WinActive("ahk_class icoSKYPE") or WinActive("ahk_class icoGOOGLE") or WinActive("ahk_class icoChannel") or WinActive("ahk_class icoJabber")

:::Д:::D
:::П:::P
#If

