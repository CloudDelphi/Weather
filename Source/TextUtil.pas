{*******************************************************}
{                                                       }
{       TextUtil.pas                                    }
{                                                       }
{                                                       }
{       Author  : A. Nasir Senturk                      }
{       Website : http://www.shenturk.com               }
{       E-Mail  : freedelphi@shenturk.com               }
{       Create  : 07.12.2006                            }
{       Update  : 21.03.2008                            }
{                                                       }
{*******************************************************}

unit TextUtil;

interface

uses Windows, Messages, CommCtrl, WinSock, Types, SysUtils, GdipApi, GdipObj,
  DirectDraw, Graphics;

{ GdiPlusDrawText }
procedure GdiPlusDrawText(gpCanvas: TGPGraphics; const Caption: WideString;
  Left, Top: Single; const FontName: WideString; gpFontStyle: FontStyle = FontStyleRegular;
  gpAlignment: StringAlignment = StringAlignmentNear; Size: Integer = 10;
  gpColor: TGPColor = aclBlack); overload;

{ GdiPlusDrawText }
procedure GdiPlusDrawText(gpCanvas: TGPGraphics; const Caption: WideString;
  gpRect: TGPRectF; Font: TFont; gpAlignment: StringAlignment = StringAlignmentNear;
  gpColor: TGPColor = aclBlack; Shadow: Boolean = True); overload;

{ GdiPlusMeasureString }
procedure GdiPlusMeasureString(gpCanvas: TGPGraphics; const Caption: WideString;
  out outRect: TGPRectF; Font: TFont; gpAlignment: StringAlignment = StringAlignmentNear);

{ MakeRectF }
function MakeRectF(const Rect: TRect): TGPRectF;

{ OffsetRectF }
procedure OffsetRectF(var RectF: TGPRectF; dx, dy: Single);

{ InflateRectF }
procedure InflateRectF(var RectF: TGPRectF; dx, dy: Single);

{ CopyRectF }
function CopyRectF(const Rect: TGPRectF): TGPRectF;

implementation

{ GdiPlusDrawText }
procedure GdiPlusDrawText(gpCanvas: TGPGraphics; const Caption: WideString;
  Left, Top: Single; const FontName: WideString; gpFontStyle: FontStyle = FontStyleRegular;
  gpAlignment: StringAlignment = StringAlignmentNear; Size: Integer = 10;
  gpColor: TGPColor = aclBlack); overload;
var
  gpBrush: TGPSolidBrush;
  gpFont: TGPFont;
  gpFormat: TGPStringFormat;
  gpPoint: TGPPointF;
begin
  gpBrush := TGPSolidBrush.Create( gpColor );
  try
    gpFont := TGPFont.Create(FontName, Size, gpFontStyle);
    try

      gpFormat := TGPStringFormat.Create;
      try

        gpCanvas.SetTextRenderingHint(TextRenderingHintAntiAlias);
        gpFormat.SetAlignment(gpAlignment);

        gpPoint.X := Left;
        gpPoint.Y := Top;

        gpCanvas.DrawString( WideString(Caption), Length(Caption), gpFont,
          gpPoint, gpFormat, gpBrush );

      finally
        gpFormat.Free;
      end;
    finally
      gpFont.Free;
    end;
  finally
    gpBrush.Free;
  end;
end;

{ GdiPlusDrawText }
procedure GdiPlusDrawText(gpCanvas: TGPGraphics; const Caption: WideString;
  gpRect: TGPRectF; Font: TFont; gpAlignment: StringAlignment = StringAlignmentNear;
  gpColor: TGPColor = aclBlack; Shadow: Boolean = True); overload;
var
  DC: HDC;
  gpBrush: TGPSolidBrush;
  gpFont: TGPFont;
  gpFormat: TGPStringFormat;
  R: TGPRectF;
begin
  DC := GetDC(GetDesktopWindow());
  try

    gpBrush := TGPSolidBrush.Create( gpColor );
    try
      gpFont := TGPFont.Create(DC, Font.Handle);
      try

        gpFormat := TGPStringFormat.Create;
        try
          gpCanvas.SetTextRenderingHint(TextRenderingHintAntiAlias);
          gpFormat.SetAlignment(gpAlignment);

          if Shadow then
          begin
            R := CopyRectF(gpRect);
            OffsetRectF(R, 1.0, 1.0);
            gpBrush.SetColor(aclBlack);
            gpCanvas.DrawString( WideString(Caption), Length(Caption), gpFont,
              R, gpFormat, gpBrush );
            gpBrush.SetColor(gpColor);
          end;

          gpCanvas.DrawString( WideString(Caption), Length(Caption), gpFont,
            gpRect, gpFormat, gpBrush );
            
        finally
          gpFormat.Free;
        end;
      finally
        gpFont.Free;
      end;
    finally
      gpBrush.Free;
    end;
  finally
    ReleaseDC(GetDesktopWindow(), DC);
  end;

end;

{ GdiPlusMeasureString }
procedure GdiPlusMeasureString(gpCanvas: TGPGraphics; const Caption: WideString;
  out outRect: TGPRectF; Font: TFont; gpAlignment: StringAlignment = StringAlignmentNear);
var
  DC: HDC;
  gpFont: TGPFont;
  gpFormat: TGPStringFormat;
  gpPoint: TGPPointF;
begin
  DC := GetDC(GetDesktopWindow());
  try

    gpFont := TGPFont.Create(DC, Font.Handle);
    try

      gpFormat := TGPStringFormat.Create;
      try
        gpPoint.X := 0.0;
        gpPoint.Y := 0.0;
        gpCanvas.SetTextRenderingHint(TextRenderingHintAntiAlias);
        gpFormat.SetAlignment(gpAlignment);
        gpCanvas.MeasureString( WideString(Caption), Length(Caption), gpFont,
          gpPoint, gpFormat, outRect );
      finally
        gpFormat.Free;
      end;
    finally
      gpFont.Free;
    end;

  finally
    ReleaseDC(GetDesktopWindow(), DC);
  end;

end;

{ MakeRectF }
function MakeRectF(const Rect: TRect): TGPRectF;
begin
  Result.X := Rect.Left;
  Result.Y := Rect.Top;
  Result.Width := Rect.Right - Rect.Left;
  Result.Height := Rect.Bottom - Rect.Top;
end;

{ OffsetRectF }
procedure OffsetRectF(var RectF: TGPRectF; dx, dy: Single);
begin
  RectF.X := RectF.X + dx;
  RectF.Y := RectF.Y + dy;
end;

{ InflateRectF }
procedure InflateRectF(var RectF: TGPRectF; dx, dy: Single);
begin
  RectF.X := RectF.X - dx;
  RectF.Y := RectF.Y - dy;
  RectF.Width := RectF.Width + dx;
  RectF.Height := RectF.Height + dy;
end;

{ CopyRectF }
function CopyRectF(const Rect: TGPRectF): TGPRectF;
begin
  Result.X := Rect.X;
  Result.Y := Rect.Y;
  Result.Width := Rect.Width;
  Result.Height := Rect.Height;
end;

end.
