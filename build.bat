rm -rf ���G���������ۑ�
mkdir ���G���������ۑ�
"C:\Program Files\AutoHotkey\Compiler\ahk2exe.exe" /in main.ahk /out .\���G���������ۑ�\���G���������ۑ�.exe /icon icon.ico /cp 932
"C:\Program Files\AutoHotkey\Compiler\ahk2exe.exe" /in register.ahk /out .\���G���������ۑ�\�X�^�[�g�A�b�v�ɓo�^.exe /icon icon.ico /cp 932
"C:\Program Files\AutoHotkey\Compiler\ahk2exe.exe" /in unregist.ahk /out .\���G���������ۑ�\�X�^�[�g�A�b�v����폜.exe /icon icon.ico /cp 932
copy config.ini .\���G���������ۑ�\
copy �g����.txt .\���G���������ۑ�\
copy ���C�Z���X.txt .\���G���������ۑ�\
zip -r .\���G���������ۑ�.zip .\���G���������ۑ�\
copy .\���G���������ۑ�.zip C:\home\projects\html\hakyll\ayachi\programs\
