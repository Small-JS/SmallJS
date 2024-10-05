import
{
	QApplication, QMainWindow, QIcon, QMenuBar, QMenu, QAction,
	QWidget, QBoxLayout, Direction, AlignmentFlag,
	QLabel, QPushButton, QPixmap,
	QObject, QStyle
} from "@nodegui/nodegui";
import * as fs from "fs";


export class MyCodeExampleApp
{
	myGreetLabel?: QLabel;

	start()
	{
		this.showWindow();
	}

	showWindow()
	{
		const window = new QMainWindow();
		window.setWindowTitle( "Hello NodeGui" );
		window.setStyleSheet( this.styleSheet() );
		window.setMenuBar( this.menuBar() );
		window.setCentralWidget( this.centralWidget() );
		window.show();
	}

	menuBar(): QMenuBar
	{
		const action = new QAction();
		action.setText( "Exit" );
		action.addEventListener( "triggered", () => { this.onFileExit(); } );

		const menu = new QMenu();
		menu.setTitle( 'File' );
		menu.addAction( action );

		const menuBar = new QMenuBar();
		menuBar.addMenu( menu );
		return menuBar;
	}

	onFileExit()
	{
		QApplication.instance().quit();
	}

	styleSheet(): string
	{
		return fs.readFileSync( "assets/default.css" ).toString();
	}

	centralWidget(): QWidget
	{
		const widget = new QWidget();
		widget.setObjectName( "root" );
		widget.setLayout( this.rootLayout() );
		return widget;
	}

	rootLayout(): QBoxLayout
	{
		const layout = new QBoxLayout( Direction.TopToBottom );
		layout.addWidget( this.imageLabel(), 0, AlignmentFlag.AlignCenter );
		layout.addWidget( this.greetLabel(), 0, AlignmentFlag.AlignCenter );
		layout.addWidget( this.button(), 0, AlignmentFlag.AlignCenter );
		return layout;
	}

	imageLabel(): QLabel
	{
		const image = new QPixmap( "assets/logo.png" );
		const label = new QLabel();
		label.setPixmap( image );
		return label;
	}

	greetLabel(): QLabel
	{
		const label = new QLabel();
		label.setObjectName( "greetLabel" );
		label.setText( "Hello from NodeGui!" );
		this.myGreetLabel = label;
		return label;
	}

	button(): QPushButton
	{
		const button = new QPushButton();
		button.setObjectName( "changeStyleButton" );
		button.setText( "Change style" );
		button.addEventListener( "clicked", () => this.onButton() );
		return button;
	}

	onButton()
	{
		this.myGreetLabel?.setInlineStyle( "color: yellow;" );
	}

};
