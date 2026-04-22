///|
pub enum BooleanAbility {
  AutoLeftMargin
  AutoRightMargin
  NoEscCtlc
  CeolStandoutGlitch
  EatNewlineGlitch
  EraseOverstrike
  GenericType
  HardCopy
  HasMetaKey
  HasStatusLine
  InsertNullGlitch
  MemoryAbove
  MemoryBelow
  MoveInsertMode
  MoveStandoutMode
  OverStrike
  StatusLineEscOk
  DestTabsMagicSmso
  TildeGlitch
  TransparentUnderline
  XonXoff
  NeedsXonXoff
  PrtrSilent
  HardCursor
  NonRevRmcup
  NoPadChar
  NonDestScrollRegion
  CanChange
  BackColorErase
  HueLightnessSaturation
  ColAddrGlitch
  CrCancelsMicroMode
  HasPrintWheel
  RowAddrGlitch
  SemiAutoRightMargin
  CpiChangesRes
  LpiChangesRes
  BackspacesWithBs
  CrtNoScrolling
  NoCorrectlyWorkingCr
  GnuHasMetaKey
  LinefeedIsNewline
  HasHardwareTabs
  ReturnDoesClrEol
  // Tip: edit this enum need to update all_boolean_abilities array too
} derive(Eq, Debug, ToJson)

///|
pub impl Show for BooleanAbility with output(self, logger) {
  logger.write_string(@debug.to_string(self))
}

///|
pub let all_boolean_abilities : @vector.Vector[BooleanAbility] = @vector.from_array([
    AutoLeftMargin,
    AutoRightMargin,
    NoEscCtlc,
    CeolStandoutGlitch,
    EatNewlineGlitch,
    EraseOverstrike,
    GenericType,
    HardCopy,
    HasMetaKey,
    HasStatusLine,
    InsertNullGlitch,
    MemoryAbove,
    MemoryBelow,
    MoveInsertMode,
    MoveStandoutMode,
    OverStrike,
    StatusLineEscOk,
    DestTabsMagicSmso,
    TildeGlitch,
    TransparentUnderline,
    XonXoff,
    NeedsXonXoff,
    PrtrSilent,
    HardCursor,
    NonRevRmcup,
    NoPadChar,
    NonDestScrollRegion,
    CanChange,
    BackColorErase,
    HueLightnessSaturation,
    ColAddrGlitch,
    CrCancelsMicroMode,
    HasPrintWheel,
    RowAddrGlitch,
    SemiAutoRightMargin,
    CpiChangesRes,
    LpiChangesRes,
    BackspacesWithBs,
    CrtNoScrolling,
    NoCorrectlyWorkingCr,
    GnuHasMetaKey,
    LinefeedIsNewline,
    HasHardwareTabs,
    ReturnDoesClrEol,
  ],
)

///|
pub enum NumericAbility {
  Columns(Int)
  InitTabs(Int)
  Lines(Int)
  LinesOfMemory(Int)
  MagicCookieGlitch(Int)
  PaddingBaudRate(Int)
  VirtualTerminal(Int)
  WidthStatusLine(Int)
  NumLabels(Int)
  LabelHeight(Int)
  LabelWidth(Int)
  MaxAttributes(Int)
  MaximumWindows(Int)
  MaxColors(Int)
  MaxPairs(Int)
  NoColorVideo(Int)
  BufferCapacity(Int)
  DotVertSpacing(Int)
  DotHorzSpacing(Int)
  MaxMicroAddress(Int)
  MaxMicroJump(Int)
  MicroColSize(Int)
  MicroLineSize(Int)
  NumberOfPins(Int)
  OutputResChar(Int)
  OutputResLine(Int)
  OutputResHorzInch(Int)
  OutputResVertInch(Int)
  PrintRate(Int)
  WideCharSize(Int)
  Buttons(Int)
  BitImageEntwining(Int)
  BitImageType(Int)
  MagicCookieGlitchUl(Int)
  CarriageReturnDelay(Int)
  NewLineDelay(Int)
  BackspaceDelay(Int)
  HorizontalTabDelay(Int)
  NumberOfFunctionKeys(Int)
  // Tip: edit this enum need to update all_numeric_abilities array too
} derive(Eq, Debug, ToJson)

///|
pub impl Show for NumericAbility with output(self, logger) {
  logger.write_string(@debug.to_string(self))
}

///|
pub let all_numeric_abilities : @vector.Vector[(Int) -> NumericAbility] = @vector.from_array([
    x => Columns(x),
    x => InitTabs(x),
    x => Lines(x),
    x => LinesOfMemory(x),
    x => MagicCookieGlitch(x),
    x => PaddingBaudRate(x),
    x => VirtualTerminal(x),
    x => WidthStatusLine(x),
    x => NumLabels(x),
    x => LabelHeight(x),
    x => LabelWidth(x),
    x => MaxAttributes(x),
    x => MaximumWindows(x),
    x => MaxColors(x),
    x => MaxPairs(x),
    x => NoColorVideo(x),
    x => BufferCapacity(x),
    x => DotVertSpacing(x),
    x => DotHorzSpacing(x),
    x => MaxMicroAddress(x),
    x => MaxMicroJump(x),
    x => MicroColSize(x),
    x => MicroLineSize(x),
    x => NumberOfPins(x),
    x => OutputResChar(x),
    x => OutputResLine(x),
    x => OutputResHorzInch(x),
    x => OutputResVertInch(x),
    x => PrintRate(x),
    x => WideCharSize(x),
    x => Buttons(x),
    x => BitImageEntwining(x),
    x => BitImageType(x),
    x => MagicCookieGlitchUl(x),
    x => CarriageReturnDelay(x),
    x => NewLineDelay(x),
    x => BackspaceDelay(x),
    x => HorizontalTabDelay(x),
    x => NumberOfFunctionKeys(x),
  ],
)

///|
pub enum StringAbility {
  BackTab(String)
  Bell(String)
  CarriageReturn(String)
  ChangeScrollRegion(String)
  ClearAllTabs(String)
  ClearScreen(String)
  ClrEol(String)
  ClrEos(String)
  ColumnAddress(String)
  CommandCharacter(String)
  CursorAddress(String)
  CursorDown(String)
  CursorHome(String)
  CursorInvisible(String)
  CursorLeft(String)
  CursorMemAddress(String)
  CursorNormal(String)
  CursorRight(String)
  CursorToLl(String)
  CursorUp(String)
  CursorVisible(String)
  DeleteCharacter(String)
  DeleteLine(String)
  DisStatusLine(String)
  DownHalfLine(String)
  EnterAltCharsetMode(String)
  EnterBlinkMode(String)
  EnterBoldMode(String)
  EnterCaMode(String)
  EnterDeleteMode(String)
  EnterDimMode(String)
  EnterInsertMode(String)
  EnterSecureMode(String)
  EnterProtectedMode(String)
  EnterReverseMode(String)
  EnterStandoutMode(String)
  EnterUnderlineMode(String)
  EraseChars(String)
  ExitAltCharsetMode(String)
  ExitAttributeMode(String)
  ExitCaMode(String)
  ExitDeleteMode(String)
  ExitInsertMode(String)
  ExitStandoutMode(String)
  ExitUnderlineMode(String)
  FlashScreen(String)
  FormFeed(String)
  FromStatusLine(String)
  Init1String(String)
  Init2String(String)
  Init3String(String)
  InitFile(String)
  InsertCharacter(String)
  InsertLine(String)
  InsertPadding(String)
  KeyBackspace(String)
  KeyCatab(String)
  KeyClear(String)
  KeyCtab(String)
  KeyDc(String)
  KeyDl(String)
  KeyDown(String)
  KeyEic(String)
  KeyEol(String)
  KeyEos(String)
  KeyF0(String)
  KeyF1(String)
  KeyF10(String)
  KeyF2(String)
  KeyF3(String)
  KeyF4(String)
  KeyF5(String)
  KeyF6(String)
  KeyF7(String)
  KeyF8(String)
  KeyF9(String)
  KeyHome(String)
  KeyIc(String)
  KeyIl(String)
  KeyLeft(String)
  KeyLl(String)
  KeyNpage(String)
  KeyPpage(String)
  KeyRight(String)
  KeySf(String)
  KeySr(String)
  KeyStab(String)
  KeyUp(String)
  KeypadLocal(String)
  KeypadXmit(String)
  LabF0(String)
  LabF1(String)
  LabF10(String)
  LabF2(String)
  LabF3(String)
  LabF4(String)
  LabF5(String)
  LabF6(String)
  LabF7(String)
  LabF8(String)
  LabF9(String)
  MetaOff(String)
  MetaOn(String)
  Newline(String)
  PadChar(String)
  ParmDch(String)
  ParmDeleteLine(String)
  ParmDownCursor(String)
  ParmIch(String)
  ParmIndex(String)
  ParmInsertLine(String)
  ParmLeftCursor(String)
  ParmRightCursor(String)
  ParmRindex(String)
  ParmUpCursor(String)
  PkeyKey(String)
  PkeyLocal(String)
  PkeyXmit(String)
  PrintScreen(String)
  PrtrOff(String)
  PrtrOn(String)
  RepeatChar(String)
  Reset1String(String)
  Reset2String(String)
  Reset3String(String)
  ResetFile(String)
  RestoreCursor(String)
  RowAddress(String)
  SaveCursor(String)
  ScrollForward(String)
  ScrollReverse(String)
  SetAttributes(String)
  SetTab(String)
  SetWindow(String)
  Tab(String)
  ToStatusLine(String)
  UnderlineChar(String)
  UpHalfLine(String)
  InitProg(String)
  KeyA1(String)
  KeyA3(String)
  KeyB2(String)
  KeyC1(String)
  KeyC3(String)
  PrtrNon(String)
  CharPadding(String)
  AcsChars(String)
  PlabNorm(String)
  KeyBtab(String)
  EnterXonMode(String)
  ExitXonMode(String)
  EnterAmMode(String)
  ExitAmMode(String)
  XonCharacter(String)
  XoffCharacter(String)
  EnaAcs(String)
  LabelOn(String)
  LabelOff(String)
  KeyBeg(String)
  KeyCancel(String)
  KeyClose(String)
  KeyCommand(String)
  KeyCopy(String)
  KeyCreate(String)
  KeyEnd(String)
  KeyEnter(String)
  KeyExit(String)
  KeyFind(String)
  KeyHelp(String)
  KeyMark(String)
  KeyMessage(String)
  KeyMove(String)
  KeyNext(String)
  KeyOpen(String)
  KeyOptions(String)
  KeyPrevious(String)
  KeyPrint(String)
  KeyRedo(String)
  KeyReference(String)
  KeyRefresh(String)
  KeyReplace(String)
  KeyRestart(String)
  KeyResume(String)
  KeySave(String)
  KeySuspend(String)
  KeyUndo(String)
  KeySbeg(String)
  KeyScancel(String)
  KeyScommand(String)
  KeyScopy(String)
  KeyScreate(String)
  KeySdc(String)
  KeySdl(String)
  KeySelect(String)
  KeySend(String)
  KeySeol(String)
  KeySexit(String)
  KeySfind(String)
  KeyShelp(String)
  KeyShome(String)
  KeySic(String)
  KeySleft(String)
  KeySmessage(String)
  KeySmove(String)
  KeySnext(String)
  KeySoptions(String)
  KeySprevious(String)
  KeySprint(String)
  KeySredo(String)
  KeySreplace(String)
  KeySright(String)
  KeySrsume(String)
  KeySsave(String)
  KeySsuspend(String)
  KeySundo(String)
  ReqForInput(String)
  KeyF11(String)
  KeyF12(String)
  KeyF13(String)
  KeyF14(String)
  KeyF15(String)
  KeyF16(String)
  KeyF17(String)
  KeyF18(String)
  KeyF19(String)
  KeyF20(String)
  KeyF21(String)
  KeyF22(String)
  KeyF23(String)
  KeyF24(String)
  KeyF25(String)
  KeyF26(String)
  KeyF27(String)
  KeyF28(String)
  KeyF29(String)
  KeyF30(String)
  KeyF31(String)
  KeyF32(String)
  KeyF33(String)
  KeyF34(String)
  KeyF35(String)
  KeyF36(String)
  KeyF37(String)
  KeyF38(String)
  KeyF39(String)
  KeyF40(String)
  KeyF41(String)
  KeyF42(String)
  KeyF43(String)
  KeyF44(String)
  KeyF45(String)
  KeyF46(String)
  KeyF47(String)
  KeyF48(String)
  KeyF49(String)
  KeyF50(String)
  KeyF51(String)
  KeyF52(String)
  KeyF53(String)
  KeyF54(String)
  KeyF55(String)
  KeyF56(String)
  KeyF57(String)
  KeyF58(String)
  KeyF59(String)
  KeyF60(String)
  KeyF61(String)
  KeyF62(String)
  KeyF63(String)
  ClrBol(String)
  ClearMargins(String)
  SetLeftMargin(String)
  SetRightMargin(String)
  LabelFormat(String)
  SetClock(String)
  DisplayClock(String)
  RemoveClock(String)
  CreateWindow(String)
  GotoWindow(String)
  Hangup(String)
  DialPhone(String)
  QuickDial(String)
  Tone(String)
  Pulse(String)
  FlashHook(String)
  FixedPause(String)
  WaitTone(String)
  User0(String)
  User1(String)
  User2(String)
  User3(String)
  User4(String)
  User5(String)
  User6(String)
  User7(String)
  User8(String)
  User9(String)
  OrigPair(String)
  OrigColors(String)
  InitializeColor(String)
  InitializePair(String)
  SetColorPair(String)
  SetForeground(String)
  SetBackground(String)
  ChangeCharPitch(String)
  ChangeLinePitch(String)
  ChangeResHorz(String)
  ChangeResVert(String)
  DefineChar(String)
  EnterDoublewideMode(String)
  EnterDraftQuality(String)
  EnterItalicsMode(String)
  EnterLeftwardMode(String)
  EnterMicroMode(String)
  EnterNearLetterQuality(String)
  EnterNormalQuality(String)
  EnterShadowMode(String)
  EnterSubscriptMode(String)
  EnterSuperscriptMode(String)
  EnterUpwardMode(String)
  ExitDoublewideMode(String)
  ExitItalicsMode(String)
  ExitLeftwardMode(String)
  ExitMicroMode(String)
  ExitShadowMode(String)
  ExitSubscriptMode(String)
  ExitSuperscriptMode(String)
  ExitUpwardMode(String)
  MicroColumnAddress(String)
  MicroDown(String)
  MicroLeft(String)
  MicroRight(String)
  MicroRowAddress(String)
  MicroUp(String)
  OrderOfPins(String)
  ParmDownMicro(String)
  ParmLeftMicro(String)
  ParmRightMicro(String)
  ParmUpMicro(String)
  SelectCharSet(String)
  SetBottomMargin(String)
  SetBottomMarginParm(String)
  SetLeftMarginParm(String)
  SetRightMarginParm(String)
  SetTopMargin(String)
  SetTopMarginParm(String)
  StartBitImage(String)
  StartCharSetDef(String)
  StopBitImage(String)
  StopCharSetDef(String)
  SubscriptCharacters(String)
  SuperscriptCharacters(String)
  TheseCauseCr(String)
  ZeroMotion(String)
  CharSetNames(String)
  KeyMouse(String)
  MouseInfo(String)
  ReqMousePos(String)
  GetMouse(String)
  SetAForeground(String)
  SetABackground(String)
  PkeyPlab(String)
  DeviceType(String)
  CodeSetInit(String)
  Set0DesSeq(String)
  Set1DesSeq(String)
  Set2DesSeq(String)
  Set3DesSeq(String)
  SetLrMargin(String)
  SetTbMargin(String)
  BitImageRepeat(String)
  BitImageNewline(String)
  BitImageCarriageReturn(String)
  ColorNames(String)
  DefineBitImageRegion(String)
  EndBitImageRegion(String)
  SetColorBand(String)
  SetPageLength(String)
  DisplayPcChar(String)
  EnterPcCharsetMode(String)
  ExitPcCharsetMode(String)
  EnterScancodeMode(String)
  ExitScancodeMode(String)
  PcTermOptions(String)
  ScancodeEscape(String)
  AltScancodeEsc(String)
  EnterHorizontalHlMode(String)
  EnterLeftHlMode(String)
  EnterLowHlMode(String)
  EnterRightHlMode(String)
  EnterTopHlMode(String)
  EnterVerticalHlMode(String)
  SetAAttributes(String)
  SetPglenInch(String)
  TermcapInit2(String)
  TermcapReset(String)
  LinefeedIfNotLf(String)
  BackspaceIfNotBs(String)
  OtherNonFunctionKeys(String)
  ArrowKeyMap(String)
  AcsUlcorner(String)
  AcsLlcorner(String)
  AcsUrcorner(String)
  AcsLrcorner(String)
  AcsLtee(String)
  AcsRtee(String)
  AcsBtee(String)
  AcsTtee(String)
  AcsHline(String)
  AcsVline(String)
  AcsPlus(String)
  MemoryLock(String)
  MemoryUnlock(String)
  BoxChars1(String)
  // Tip: edit this enum need to update all_string_abilities array too
} derive(Eq, Debug, ToJson)

///|
pub impl Show for StringAbility with output(self, logger) {
  logger.write_string(@debug.to_string(self))
}

///|
pub let all_string_abilities : @vector.Vector[(String) -> StringAbility] = @vector.from_array([
    x => BackTab(x),
    x => Bell(x),
    x => CarriageReturn(x),
    x => ChangeScrollRegion(x),
    x => ClearAllTabs(x),
    x => ClearScreen(x),
    x => ClrEol(x),
    x => ClrEos(x),
    x => ColumnAddress(x),
    x => CommandCharacter(x),
    x => CursorAddress(x),
    x => CursorDown(x),
    x => CursorHome(x),
    x => CursorInvisible(x),
    x => CursorLeft(x),
    x => CursorMemAddress(x),
    x => CursorNormal(x),
    x => CursorRight(x),
    x => CursorToLl(x),
    x => CursorUp(x),
    x => CursorVisible(x),
    x => DeleteCharacter(x),
    x => DeleteLine(x),
    x => DisStatusLine(x),
    x => DownHalfLine(x),
    x => EnterAltCharsetMode(x),
    x => EnterBlinkMode(x),
    x => EnterBoldMode(x),
    x => EnterCaMode(x),
    x => EnterDeleteMode(x),
    x => EnterDimMode(x),
    x => EnterInsertMode(x),
    x => EnterSecureMode(x),
    x => EnterProtectedMode(x),
    x => EnterReverseMode(x),
    x => EnterStandoutMode(x),
    x => EnterUnderlineMode(x),
    x => EraseChars(x),
    x => ExitAltCharsetMode(x),
    x => ExitAttributeMode(x),
    x => ExitCaMode(x),
    x => ExitDeleteMode(x),
    x => ExitInsertMode(x),
    x => ExitStandoutMode(x),
    x => ExitUnderlineMode(x),
    x => FlashScreen(x),
    x => FormFeed(x),
    x => FromStatusLine(x),
    x => Init1String(x),
    x => Init2String(x),
    x => Init3String(x),
    x => InitFile(x),
    x => InsertCharacter(x),
    x => InsertLine(x),
    x => InsertPadding(x),
    x => KeyBackspace(x),
    x => KeyCatab(x),
    x => KeyClear(x),
    x => KeyCtab(x),
    x => KeyDc(x),
    x => KeyDl(x),
    x => KeyDown(x),
    x => KeyEic(x),
    x => KeyEol(x),
    x => KeyEos(x),
    x => KeyF0(x),
    x => KeyF1(x),
    x => KeyF10(x),
    x => KeyF2(x),
    x => KeyF3(x),
    x => KeyF4(x),
    x => KeyF5(x),
    x => KeyF6(x),
    x => KeyF7(x),
    x => KeyF8(x),
    x => KeyF9(x),
    x => KeyHome(x),
    x => KeyIc(x),
    x => KeyIl(x),
    x => KeyLeft(x),
    x => KeyLl(x),
    x => KeyNpage(x),
    x => KeyPpage(x),
    x => KeyRight(x),
    x => KeySf(x),
    x => KeySr(x),
    x => KeyStab(x),
    x => KeyUp(x),
    x => KeypadLocal(x),
    x => KeypadXmit(x),
    x => LabF0(x),
    x => LabF1(x),
    x => LabF10(x),
    x => LabF2(x),
    x => LabF3(x),
    x => LabF4(x),
    x => LabF5(x),
    x => LabF6(x),
    x => LabF7(x),
    x => LabF8(x),
    x => LabF9(x),
    x => MetaOff(x),
    x => MetaOn(x),
    x => Newline(x),
    x => PadChar(x),
    x => ParmDch(x),
    x => ParmDeleteLine(x),
    x => ParmDownCursor(x),
    x => ParmIch(x),
    x => ParmIndex(x),
    x => ParmInsertLine(x),
    x => ParmLeftCursor(x),
    x => ParmRightCursor(x),
    x => ParmRindex(x),
    x => ParmUpCursor(x),
    x => PkeyKey(x),
    x => PkeyLocal(x),
    x => PkeyXmit(x),
    x => PrintScreen(x),
    x => PrtrOff(x),
    x => PrtrOn(x),
    x => RepeatChar(x),
    x => Reset1String(x),
    x => Reset2String(x),
    x => Reset3String(x),
    x => ResetFile(x),
    x => RestoreCursor(x),
    x => RowAddress(x),
    x => SaveCursor(x),
    x => ScrollForward(x),
    x => ScrollReverse(x),
    x => SetAttributes(x),
    x => SetTab(x),
    x => SetWindow(x),
    x => Tab(x),
    x => ToStatusLine(x),
    x => UnderlineChar(x),
    x => UpHalfLine(x),
    x => InitProg(x),
    x => KeyA1(x),
    x => KeyA3(x),
    x => KeyB2(x),
    x => KeyC1(x),
    x => KeyC3(x),
    x => PrtrNon(x),
    x => CharPadding(x),
    x => AcsChars(x),
    x => PlabNorm(x),
    x => KeyBtab(x),
    x => EnterXonMode(x),
    x => ExitXonMode(x),
    x => EnterAmMode(x),
    x => ExitAmMode(x),
    x => XonCharacter(x),
    x => XoffCharacter(x),
    x => EnaAcs(x),
    x => LabelOn(x),
    x => LabelOff(x),
    x => KeyBeg(x),
    x => KeyCancel(x),
    x => KeyClose(x),
    x => KeyCommand(x),
    x => KeyCopy(x),
    x => KeyCreate(x),
    x => KeyEnd(x),
    x => KeyEnter(x),
    x => KeyExit(x),
    x => KeyFind(x),
    x => KeyHelp(x),
    x => KeyMark(x),
    x => KeyMessage(x),
    x => KeyMove(x),
    x => KeyNext(x),
    x => KeyOpen(x),
    x => KeyOptions(x),
    x => KeyPrevious(x),
    x => KeyPrint(x),
    x => KeyRedo(x),
    x => KeyReference(x),
    x => KeyRefresh(x),
    x => KeyReplace(x),
    x => KeyRestart(x),
    x => KeyResume(x),
    x => KeySave(x),
    x => KeySuspend(x),
    x => KeyUndo(x),
    x => KeySbeg(x),
    x => KeyScancel(x),
    x => KeyScommand(x),
    x => KeyScopy(x),
    x => KeyScreate(x),
    x => KeySdc(x),
    x => KeySdl(x),
    x => KeySelect(x),
    x => KeySend(x),
    x => KeySeol(x),
    x => KeySexit(x),
    x => KeySfind(x),
    x => KeyShelp(x),
    x => KeyShome(x),
    x => KeySic(x),
    x => KeySleft(x),
    x => KeySmessage(x),
    x => KeySmove(x),
    x => KeySnext(x),
    x => KeySoptions(x),
    x => KeySprevious(x),
    x => KeySprint(x),
    x => KeySredo(x),
    x => KeySreplace(x),
    x => KeySright(x),
    x => KeySrsume(x),
    x => KeySsave(x),
    x => KeySsuspend(x),
    x => KeySundo(x),
    x => ReqForInput(x),
    x => KeyF11(x),
    x => KeyF12(x),
    x => KeyF13(x),
    x => KeyF14(x),
    x => KeyF15(x),
    x => KeyF16(x),
    x => KeyF17(x),
    x => KeyF18(x),
    x => KeyF19(x),
    x => KeyF20(x),
    x => KeyF21(x),
    x => KeyF22(x),
    x => KeyF23(x),
    x => KeyF24(x),
    x => KeyF25(x),
    x => KeyF26(x),
    x => KeyF27(x),
    x => KeyF28(x),
    x => KeyF29(x),
    x => KeyF30(x),
    x => KeyF31(x),
    x => KeyF32(x),
    x => KeyF33(x),
    x => KeyF34(x),
    x => KeyF35(x),
    x => KeyF36(x),
    x => KeyF37(x),
    x => KeyF38(x),
    x => KeyF39(x),
    x => KeyF40(x),
    x => KeyF41(x),
    x => KeyF42(x),
    x => KeyF43(x),
    x => KeyF44(x),
    x => KeyF45(x),
    x => KeyF46(x),
    x => KeyF47(x),
    x => KeyF48(x),
    x => KeyF49(x),
    x => KeyF50(x),
    x => KeyF51(x),
    x => KeyF52(x),
    x => KeyF53(x),
    x => KeyF54(x),
    x => KeyF55(x),
    x => KeyF56(x),
    x => KeyF57(x),
    x => KeyF58(x),
    x => KeyF59(x),
    x => KeyF60(x),
    x => KeyF61(x),
    x => KeyF62(x),
    x => KeyF63(x),
    x => ClrBol(x),
    x => ClearMargins(x),
    x => SetLeftMargin(x),
    x => SetRightMargin(x),
    x => LabelFormat(x),
    x => SetClock(x),
    x => DisplayClock(x),
    x => RemoveClock(x),
    x => CreateWindow(x),
    x => GotoWindow(x),
    x => Hangup(x),
    x => DialPhone(x),
    x => QuickDial(x),
    x => Tone(x),
    x => Pulse(x),
    x => FlashHook(x),
    x => FixedPause(x),
    x => WaitTone(x),
    x => User0(x),
    x => User1(x),
    x => User2(x),
    x => User3(x),
    x => User4(x),
    x => User5(x),
    x => User6(x),
    x => User7(x),
    x => User8(x),
    x => User9(x),
    x => OrigPair(x),
    x => OrigColors(x),
    x => InitializeColor(x),
    x => InitializePair(x),
    x => SetColorPair(x),
    x => SetForeground(x),
    x => SetBackground(x),
    x => ChangeCharPitch(x),
    x => ChangeLinePitch(x),
    x => ChangeResHorz(x),
    x => ChangeResVert(x),
    x => DefineChar(x),
    x => EnterDoublewideMode(x),
    x => EnterDraftQuality(x),
    x => EnterItalicsMode(x),
    x => EnterLeftwardMode(x),
    x => EnterMicroMode(x),
    x => EnterNearLetterQuality(x),
    x => EnterNormalQuality(x),
    x => EnterShadowMode(x),
    x => EnterSubscriptMode(x),
    x => EnterSuperscriptMode(x),
    x => EnterUpwardMode(x),
    x => ExitDoublewideMode(x),
    x => ExitItalicsMode(x),
    x => ExitLeftwardMode(x),
    x => ExitMicroMode(x),
    x => ExitShadowMode(x),
    x => ExitSubscriptMode(x),
    x => ExitSuperscriptMode(x),
    x => ExitUpwardMode(x),
    x => MicroColumnAddress(x),
    x => MicroDown(x),
    x => MicroLeft(x),
    x => MicroRight(x),
    x => MicroRowAddress(x),
    x => MicroUp(x),
    x => OrderOfPins(x),
    x => ParmDownMicro(x),
    x => ParmLeftMicro(x),
    x => ParmRightMicro(x),
    x => ParmUpMicro(x),
    x => SelectCharSet(x),
    x => SetBottomMargin(x),
    x => SetBottomMarginParm(x),
    x => SetLeftMarginParm(x),
    x => SetRightMarginParm(x),
    x => SetTopMargin(x),
    x => SetTopMarginParm(x),
    x => StartBitImage(x),
    x => StartCharSetDef(x),
    x => StopBitImage(x),
    x => StopCharSetDef(x),
    x => SubscriptCharacters(x),
    x => SuperscriptCharacters(x),
    x => TheseCauseCr(x),
    x => ZeroMotion(x),
    x => CharSetNames(x),
    x => KeyMouse(x),
    x => MouseInfo(x),
    x => ReqMousePos(x),
    x => GetMouse(x),
    x => SetAForeground(x),
    x => SetABackground(x),
    x => PkeyPlab(x),
    x => DeviceType(x),
    x => CodeSetInit(x),
    x => Set0DesSeq(x),
    x => Set1DesSeq(x),
    x => Set2DesSeq(x),
    x => Set3DesSeq(x),
    x => SetLrMargin(x),
    x => SetTbMargin(x),
    x => BitImageRepeat(x),
    x => BitImageNewline(x),
    x => BitImageCarriageReturn(x),
    x => ColorNames(x),
    x => DefineBitImageRegion(x),
    x => EndBitImageRegion(x),
    x => SetColorBand(x),
    x => SetPageLength(x),
    x => DisplayPcChar(x),
    x => EnterPcCharsetMode(x),
    x => ExitPcCharsetMode(x),
    x => EnterScancodeMode(x),
    x => ExitScancodeMode(x),
    x => PcTermOptions(x),
    x => ScancodeEscape(x),
    x => AltScancodeEsc(x),
    x => EnterHorizontalHlMode(x),
    x => EnterLeftHlMode(x),
    x => EnterLowHlMode(x),
    x => EnterRightHlMode(x),
    x => EnterTopHlMode(x),
    x => EnterVerticalHlMode(x),
    x => SetAAttributes(x),
    x => SetPglenInch(x),
    x => TermcapInit2(x),
    x => TermcapReset(x),
    x => LinefeedIfNotLf(x),
    x => BackspaceIfNotBs(x),
    x => OtherNonFunctionKeys(x),
    x => ArrowKeyMap(x),
    x => AcsUlcorner(x),
    x => AcsLlcorner(x),
    x => AcsUrcorner(x),
    x => AcsLrcorner(x),
    x => AcsLtee(x),
    x => AcsRtee(x),
    x => AcsBtee(x),
    x => AcsTtee(x),
    x => AcsHline(x),
    x => AcsVline(x),
    x => AcsPlus(x),
    x => MemoryLock(x),
    x => MemoryUnlock(x),
    x => BoxChars1(x),
  ],
)
