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

// Layout
let qLayout: nodegui.QLayout;
let qBoxLayout: nodegui.QBoxLayout;

// Menu
let qAction: nodegui.QAction;
let qMenu: nodegui.QMenu;
let qMenuBar: nodegui.QMenuBar;
// Note: The enums SequenceFormat and SequenceMatch of QKeySequence are not exported by NodeGui.
let qKeySequence: nodegui.QKeySequence;

// Widget
let qWidget: nodegui.QWidget;
let qFrame: nodegui.QFrame;
let qLabel: nodegui.QLabel;
let qMainWindow: nodegui.QMainWindow;

// Enums, used as integer constants in the ST classes.
let alignmentFlag = nodegui.AlignmentFlag.AlignCenter;
let arrowType = nodegui.ArrowType.RightArrow;
let aspectRatioMode = nodegui.AspectRatioMode.KeepAspectRatio;
let checkState = nodegui.CheckState.PartiallyChecked;
let direction = nodegui.Direction.TopToBottom;
let timerType = nodegui.TimerType.PreciseTimer;
let toolButtonStyle = nodegui.ToolButtonStyle.ToolButtonTextBesideIcon;
let toolButtonPopupMode = nodegui.ToolButtonPopupMode.MenuButtonPopup;
let widgetEventType = nodegui.WidgetEventTypes.Timer;
