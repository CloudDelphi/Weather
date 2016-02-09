{*******************************************************}
{                                                       }
{       HbrntDlg.pas                                    }
{                                                       }
{                                                       }
{       Author  : A. Nasir Senturk                      }
{       Website : http://www.shenturk.com               }
{       E-Mail  : freedelphi@shenturk.com               }
{       Create  : 07.12.2006                            }
{       Update  : 21.03.2008                            }
{                                                       }
{*******************************************************}

unit HbrntDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  THibernateForm = class(TForm)
    GroupBox2: TGroupBox;
    OkBtn: TButton;
    CheckBox1: TCheckBox;
    Label1: TStaticText;
    Label2: TStaticText;
    Label3: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses OptnsDlg, ConstDef;

{$R *.dfm}

procedure THibernateForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  IniFile.WriteBool(sGeneral, sHibernateAlert, not CheckBox1.Checked);
  IniFile.UpdateFile;
end;

end.
