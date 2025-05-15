[Setup]
AppName=Harmony Launcher
AppPublisher=Harmony
UninstallDisplayName=Harmony
AppVersion=${project.version}
AppSupportURL=https://Harmony.net/
DefaultDirName={localappdata}\Harmony

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Harmony.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=HarmonySetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\native-win32\Harmony.exe"; DestDir: "{app}"
Source: "${basedir}\native-win32\Harmony.jar"; DestDir: "{app}"
Source: "${basedir}\native\build32\Release\launcher_x86.dll"; DestDir: "{app}"
Source: "${basedir}\native-win32\config.json"; DestDir: "{app}"
Source: "${basedir}\native-win32\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Harmony\Harmony"; Filename: "{app}\Harmony.exe"
Name: "{userprograms}\Harmony\Harmony (configure)"; Filename: "{app}\Harmony.exe"; Parameters: "--configure"
Name: "{userprograms}\Harmony\Harmony (safe mode)"; Filename: "{app}\Harmony.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Harmony"; Filename: "{app}\Harmony.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Harmony.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Harmony.exe"; Description: "&Open Harmony"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Harmony.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.harmony\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"