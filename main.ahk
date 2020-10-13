
;Clip Studio
GroupAdd autosaveahk, ahk_class 742DEA58-ED6B-4402-BC11-20DFC6D08040

;SAI
GroupAdd autosaveahk, ahk_class sfl_window_class

;SAI2
GroupAdd autosaveahk, ahk_class sflRootWindow

;AZPainter2
GroupAdd autosaveahk, ahk_exe AzPainter2.exe

;neko paint
GroupAdd autosaveahk, ahk_class TNekoPaintForm

; FireAlpaca
GroupAdd autosaveahk, ahk_exe FireAlpaca.exe
;GroupAdd autosaveahk, 

;OpenCanvas
GroupAdd autosaveahk, ahk_class Tmainform


#Persistent

; �۰ʫO�s���j(��)
;IniRead, OutputVar, Filename[, Section, Key , Default]
IniRead, autosaveInterval, %A_ScriptDir%\config.ini, config,interval
IniRead, threshold, %A_ScriptDir%\config.ini, config, threshold

MsgBox,,ø�e�۰ʦs��, �N�b�C���j%autosaveInterval%�����H�ζ��m%threshold%������۰ʦs��,5

;��l���ܼ�
autosaveInterval:=autosaveInterval*60
threshold := threshold * 1000
delay := 0
;Gui, Submit  ; Save the input from the user to each control's associated variable.

SetTimer,autosave,1000


autosave() {
        global delay
        global threshold
        global autosaveInterval
        if delay > 0
        {
                delay := delay - 1
                return
        }

        If (threshold == 0) || (A_TimeIdlePhysical > %threshold%)
        {
                IfWinActive, ahk_group autosaveahk
                {
                        send,^s
                        ; ����U�����զ۰��x�s���ɶ��]��^
                        delay:=autosaveInterval
                        return
                }
        }
        return 
}

^~s::backup()

backup() {
        if WinActive("ahk_class sfl_window_class") {
                backupCanvas("sfl_window_class")
        }

        if WinActive("ahk_class sflRootWindow") {
                backupCanvas("sflRootWindow")
        }
}

;^q::test()

;test() {
        ;WinGetTitle, Title, ahk_class sfl_window_class
;        FileName := getFilePath("Preview 2017.1.19 - D:\hoge\foo\new.sai")
;        MsgBox % FileName
;        MsgBox % 
;}

getFilePath(title)
{
        path := RegexReplace(title, ".*- *", "")
        path := RegexReplace(path, "\( *\* *\)$", "")
        path := RegexReplace(path, "^Windows", "")
        path := RegexReplace(path, "\((.:)\)", "$1")
        path := RegexReplace(path, " /", "/")
        path := RegexReplace(path, "/ ", "/")
        path := RegexReplace(path, "^ *", "")
        path := RegexReplace(path, " *$", "")
        return path
}

getFileName(path) {
        fileName := RegexReplace(path, "(.*\/)*", "")
        return fileName
}

dropExt(fileName) {
        return RegexReplace(fileName, "\..*$", "")
}

takeExt(fileName) {
        return RegexReplace(fileName,  "^[^.]*.", "")
}

backupCanvas(Name) {
        MsgBox,,,���b�ǳƳƥ�,1
        Sleep, 30000
        WinGetTitle, Title, ahk_class %Name%
        FilePath      := getFilePath(Title)
        FileName      := getFileName(FilePath)
        FileNameNoExt := dropExt(FileName)
        Ext           := takeExt(FileName)

        FormatTime, Now, ,yyyyMMddHHmmss
        Dest := A_ScriptDir . "\backup\" . FileNameNoExt . Now . "." . Ext
        Source := FilePath
        Source := RegexReplace(Source, "/", "\")
        if FileExist(Source)
        {
                FileCopy, %Source%, %Dest%
                if ErrorLevel = 0
                {
                        MsgBox, ���\�i��ƥ�
                }
                else {
                        MsgBox, �ɮ׽ƻs����
                }
        }
}
