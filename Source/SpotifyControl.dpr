library SpotifyControl;
uses
  Windows,
  ShlObj,
  TlHelp32,
  System.SysUtils;

  const
    SPOTIFY_ID          = 'SpotifyMainWindow';
    APPCOMMAND          = $0319;
    C_PLAY_PAUSE        = $E0000;
    C_STOP              = $D0000;
    C_NEXT              = $B0000;
    C_PREV              = $C0000;
    C_VOL_DOWN          = $90000;
    C_VOL_UP            = $A0000;
    C_VOL_MUTE          = $80000;


{$R *.res}

function GetSpecialFolder(const CSIDL: integer) : string;
var
  RecPath : PWideChar;
begin
  RecPath := StrAlloc(MAX_PATH);
    try
    FillChar(RecPath^, MAX_PATH, 0);
    if SHGetSpecialFolderPath(0, RecPath, CSIDL, false)
      then result := RecPath
      else result := '';
    finally
      StrDispose(RecPath);
    end;
end;

procedure DoCommand(hw: HWND; cmd:Integer);
begin
  SendMessage(hw, APPCOMMAND, 0, cmd);
end;

function GetSpotifyHWND: HWND;
begin
  Result := FindWindow(PWideChar(SPOTIFY_ID), nil);
end;

function xNew:HWND;export;stdcall;
begin
  Result := GetSpotifyHWND;
end;

procedure PlayPause(hw:HWND);export;stdcall;
begin
  DoCommand(hw, C_PLAY_PAUSE);
end;

procedure Stop(hw:HWND);export;stdcall;
begin
  DoCommand(hw, C_STOP);
end;

procedure Next(hw:HWND);export;stdcall;
begin
  DoCommand(hw, C_NEXT);
end;

procedure Previous(hw:HWND);export;stdcall;
begin
  DoCommand(hw, C_PREV);
end;

procedure VolDown(hw:HWND);export;stdcall;
begin
  DoCommand(hw, C_VOL_DOWN);
end;

procedure VolUp(hw:HWND);export;stdcall;
begin
  DoCommand(hw, C_VOL_UP);
end;

procedure Mute(hw:HWND);export;stdcall;
begin
  DoCommand(hw, C_VOL_MUTE);
end;

function Info(hw:HWND):PChar;export;stdcall;
var
  Res: String;
  procedure RemovePrefix;
  begin
    Res := StringReplace(Res, 'Spotify - ', '', []);
  end;
  procedure RemoveWeirdDash;
  begin
    Res := StringReplace(Res, ' '+Chr(8211)+' ', ';', []);
  end;
begin
  SetLength(Res, GetWindowTextLength(hw));
  GetWindowText(hw, PChar(Res), Length(Result)+1);
  Res := PChar(Res);
  RemovePrefix;
  RemoveWeirdDash;
  Result := PChar(Res);
end;

exports
  xNew,
  PlayPause,
  Stop,
  Next,
  Previous,
  VolDown,
  VolUp,
  Mute,
  Info;


begin
end.
