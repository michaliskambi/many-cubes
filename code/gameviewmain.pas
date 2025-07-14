{ Main view, where most of the application logic takes place.

  Feel free to use this code as a starting point for your own projects.
  This template code is in public domain, unlike most other CGE code which
  is covered by BSD or LGPL (see https://castle-engine.io/license). }
unit GameViewMain;

interface

uses Classes,
  CastleVectors, CastleComponentSerialize,
  CastleUIControls, CastleControls, CastleKeysMouse, CastleViewport,
  CastleScene, CastleTransform, CastleUtils, CastleLog;

type
  { Main view, where most of the application logic takes place. }
  TViewMain = class(TCastleView)
  published
    { Components designed using CGE editor.
      These fields will be automatically initialized at Start. }
    LabelFps: TCastleLabel;
    Viewport1: TCastleViewport;
    BoxesParent: TCastleTransform;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Start; override;
    procedure Update(const SecondsPassed: Single; var HandleInput: Boolean); override;
    function Press(const Event: TInputPressRelease): Boolean; override;
  end;

var
  ViewMain: TViewMain;

implementation

uses SysUtils;

{ TViewMain ----------------------------------------------------------------- }

constructor TViewMain.Create(AOwner: TComponent);
begin
  inherited;
  DesignUrl := 'castle-data:/gameviewmain.castle-user-interface';
end;

procedure TViewMain.Start;

  function CreateBox: TCastleBox;
  var
    Size: Single;
  begin
    Result := TCastleBox.Create(FreeAtStop);
    Result.Translation := Vector3(
      RandomFloatRange(-10, 10),
      RandomFloatRange(-10, 10),
      RandomFloatRange(-10, 10)
    );

    // randomize size
    Size := RandomFloatRange(1, 3);
    Result.Size := Vector3(Size, Size, Size);

    // randomize color
    Result.Color := Vector4(
      RandomFloatRange(0, 1),
      RandomFloatRange(0, 1),
      RandomFloatRange(0, 1),
      1.0
    );
  end;

const
  NumCubes = 1000;
var
  I: Integer;
begin
  inherited;
  for I := 0 to NumCubes - 1 do
    BoxesParent.Add(CreateBox);
end;

procedure TViewMain.Update(const SecondsPassed: Single; var HandleInput: Boolean);
begin
  inherited;
  { This virtual method is executed every frame (many times per second). }
  Assert(LabelFps <> nil, 'If you remove LabelFps from the design, remember to remove also the assignment "LabelFps.Caption := ..." from code');
  LabelFps.Caption := 'FPS: ' + Container.Fps.ToString;
end;

function TViewMain.Press(const Event: TInputPressRelease): Boolean;
var
  RandomCubeIndex: Integer;
begin
  Result := inherited;
  if Result then Exit; // allow the ancestor to handle keys

  // key Q removes box under mouse
  if Event.IsKey(keyQ) then
  begin
    if Viewport1.TransformUnderMouse is TCastleBox then
      Viewport1.TransformUnderMouse.Free; // this will also remove it from Viewport1.Items
    Exit(true); // key was handled
  end;

  // key E changes random cube's color, accesses cube by index
  if Event.IsKey(keyE) and (BoxesParent.Count <> 0) then
  begin
    RandomCubeIndex := Random(BoxesParent.Count);
    (BoxesParent[RandomCubeIndex] as TCastleBox).Color := Vector4(
      RandomFloatRange(0, 1),
      RandomFloatRange(0, 1),
      RandomFloatRange(0, 1),
      1.0
    );
    WritelnLog('Changed color of cube %d', [RandomCubeIndex]);
    Exit(true); // key was handled
  end;

  if Event.IsKey(keyO) then
  begin
    Viewport1.OcclusionCulling := not Viewport1.OcclusionCulling;
    WritelnLog('Occlusion culling is now %s', [BoolToStr(Viewport1.OcclusionCulling, true)]);
    Exit(true); // key was handled
  end;
end;

end.
