#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
~LButton::

  Loop {
    LButtonDown := GetKeyState("LButton","P")
    If (!LButtonDown)
      Break
  }

WaitTime:=DllCall("GetDoubleClickTime")/4000
KeyWait, LButton, D T%WaitTime%
If errorlevel=0
   GoSub, Routine
Return


Routine:
{

  ifwinactive ahk_class CabinetWClass
  {
    return
  }

  old_clip := ClipBoardAll    ; save old clipboard
  clipboard =
  send ,^c
  ClipWait,1

    if ErrorLevel
    {
        selected = ""
    }
    else
    {
        selected = %ClipBoard%
    }
    SetEnv, ClipBoard, %old_clip%   ; restore old clipboard

  StringLen, cliplen, selected
  if cliplen > 20
  {
    ; Avoid sending things that are not English words to GoldenDict for translation.
    return
  }

  if cliplen < 2
  {
    ; Avoid sending things that are not English words to GoldenDict for translation.
    return
  }


; send,{Ctrl down}cc{Ctrl up} can use this line or down

run GoldenDict.exe  %selected%

}

return