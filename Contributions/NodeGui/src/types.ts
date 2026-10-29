// This file imports exports from npm modules that are wrapped in ST elsewhere,
// in ../../Smalltalk/NodeGui.
// This is done to facilitate inspecting their TS types in VSCode.
// Type 'nodegui.' to list all NodeGui exports, including those not wrapped yet.
// This file is not used when running this app: main.ts does not import it.

// NodeGui docs
// https://docs.nodegui.org/

import * as nodegui from "@nodegui/nodegui";

// Base
let qObject: nodegui.QObject;
let qObjectSignals: nodegui.QObjectSignals;
let qApplication: nodegui.QApplication;
let qVariant: nodegui.QVariant;
let qSize: nodegui.QSize;
let qPoint: nodegui.QPoint;
let qRect: nodegui.QRect;
let qDate: nodegui.QDate;

// Button
let qAbstractButton: nodegui.QAbstractButton<nodegui.QAbstractButtonSignals>;
let qPushButton: nodegui.QPushButton;
let qCheckBox: nodegui.QCheckBox;
let qCheckBoxSignals: nodegui.QCheckBoxSignals;
let qRadioButton: nodegui.QRadioButton;
let qToolButton: nodegui.QToolButton;
let qToolButtonSignals: nodegui.QToolButtonSignals;
let qButtonGroup: nodegui.QButtonGroup;
let qButtonGroupSignals: nodegui.QButtonGroupSignals;

// Component
let qIcon: nodegui.QIcon;
let qPixmap: nodegui.QPixmap;
let qMovie: nodegui.QMovie;

// Layout
let qLayout: nodegui.QLayout;
let qBoxLayout: nodegui.QBoxLayout;
let qGridLayout: nodegui.QGridLayout;
let qStackedLayout: nodegui.QStackedLayout;
let qStackedLayoutSignals: nodegui.QStackedLayoutSignals;
let qFlexLayout: nodegui.FlexLayout;

// Container
let qGroupBox: nodegui.QGroupBox;
let qGroupBoxSignals: nodegui.QGroupBoxSignals;
let qScrollArea: nodegui.QScrollArea;
let qSplitter: nodegui.QSplitter;
let qSplitterSignals: nodegui.QSplitterSignals;
let qStackedWidget: nodegui.QStackedWidget;
let qStackedWidgetSignals: nodegui.QStackedWidgetSignals;
let qTabWidget: nodegui.QTabWidget;
let qTabWidgetSignals: nodegui.QTabWidgetSignals;

// Menu
let qAction: nodegui.QAction;
let qMenu: nodegui.QMenu;
let qMenuBar: nodegui.QMenuBar;
// Note: The enums SequenceFormat and SequenceMatch of QKeySequence are not exported by NodeGui.
let qKeySequence: nodegui.QKeySequence;
let qActionSignals: nodegui.QActionSignals;
let qMenuSignals: nodegui.QMenuSignals;
let qMenuBarSignals: nodegui.QMenuBarSignals;
let qShortcut: nodegui.QShortcut;
let qShortcutSignals: nodegui.QShortcutSignals;
let qSystemTrayIcon: nodegui.QSystemTrayIcon;
let qSystemTrayIconSignals: nodegui.QSystemTrayIconSignals;

// Widget
let qWidget: nodegui.QWidget;
let qFrame: nodegui.QFrame;
let qLabel: nodegui.QLabel;
let qMainWindow: nodegui.QMainWindow;
let qStatusBar: nodegui.QStatusBar;
let qStatusBarSignals: nodegui.QStatusBarSignals;
let qLabelSignals: nodegui.QLabelSignals;
let qLineEdit: nodegui.QLineEdit;
let qLineEditSignals: nodegui.QLineEditSignals;
let qProgressBar: nodegui.QProgressBar;
let qProgressBarSignals: nodegui.QProgressBarSignals;
let qLcdNumber: nodegui.QLCDNumber;
let qLcdNumberSignals: nodegui.QLCDNumberSignals;
let qCalendar: nodegui.QCalendarWidget;
let qCalendarSignals: nodegui.QCalendarWidgetSignals;

// Enums, used as integer constants in the ST classes.
// Note: The QMovie signals and the QCalendarWidget header format enums are not exported by NodeGui.
let alignmentFlag = nodegui.AlignmentFlag.AlignCenter;
let arrowType = nodegui.ArrowType.RightArrow;
let aspectRatioMode = nodegui.AspectRatioMode.KeepAspectRatio;
let cacheMode = nodegui.CacheMode.CacheAll;
let checkState = nodegui.CheckState.PartiallyChecked;
let corner = nodegui.Corner.TopRightCorner;
let cursorShape = nodegui.CursorShape.PointingHandCursor;
let dayOfWeek = nodegui.DayOfWeek.Sunday;
let direction = nodegui.Direction.TopToBottom;
let echoMode = nodegui.EchoMode.Password;
let focusPolicy = nodegui.FocusPolicy.StrongFocus;
let lcdMode = nodegui.Mode.Dec;
let movieState = nodegui.MovieState.Running;
let orientation = nodegui.Orientation.Horizontal;
let qProgressBarDirection = nodegui.QProgressBarDirection.TopToBottom;
let qSizePolicyPolicy = nodegui.QSizePolicyPolicy.Expanding;
let qSystemTrayIconActivationReason = nodegui.QSystemTrayIconActivationReason.Trigger;
let shortcutContext = nodegui.ShortcutContext.WindowShortcut;
let segmentStyle = nodegui.SegmentStyle.Flat;
let selectionMode = nodegui.SelectionMode.SingleSelection;
let shadow = nodegui.Shadow.Sunken;
let shape = nodegui.Shape.Box;
let stackingMode = nodegui.StackingMode.StackOne;
let tabPosition = nodegui.TabPosition.North;
let textFormat = nodegui.TextFormat.RichText;
let textInteractionFlag = nodegui.TextInteractionFlag.TextSelectableByMouse;
let timerType = nodegui.TimerType.PreciseTimer;
let toolButtonStyle = nodegui.ToolButtonStyle.ToolButtonTextBesideIcon;
let toolButtonPopupMode = nodegui.ToolButtonPopupMode.MenuButtonPopup;
let widgetEventType = nodegui.WidgetEventTypes.Timer;
