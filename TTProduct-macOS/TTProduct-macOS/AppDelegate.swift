//
//  AppDelegate.swift
//  TTProduct
//
//  Created by Toj on 1/4/21.
//
import Cocoa

@main
class AppDelegate: NSObject {

    private var keyWindow: NSWindow?
    private var windowController: TTWindowController?
}

extension AppDelegate: NSApplicationDelegate {

    // 默认通知中心在应用程序对象初始化之前立即发送。
    func applicationWillFinishLaunching(_ notification: Notification) {

    }
    
    // 默认的通知中心在应用程序启动和初始化之后但收到第一个事件之前发送。
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMakeRootWindowController()
        windowController?.showWindow(self)
    }
    
    // 终止前
    func applicationWillTerminate(_ notification: Notification) {
        print(className + " : " + #function)
    }
    
    // 重新打开
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        print(flag)
        if !flag {
            if windowController == nil {
                setupMakeRootWindowController()
            }
            windowController?.showWindow(self)
        }
        return true
    }
}
extension AppDelegate {
    
    private func setupMakeRootWindowController() {
        keyWindow = setupMakeWindow()
        windowController = TTWindowController(window: keyWindow)
        keyWindow?.delegate = self
    }
    
    private func setupMakeWindow() -> NSWindow {
//        let vc = ViewController()
        let vc = TTHomeViewController()
        
        let window = TTWindow(contentViewController: vc)
        window.isMovableByWindowBackground = false
        let rect = CGRect(x: 0, y: 0, width: 1000, height: 960)
        window.titleBarHeight = 50
        window.setContentSize(rect.size)
        window.center()
        return window
    }
}

extension AppDelegate: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        let windows = NSApp.windows
        if windows.count == 1 {
            windowController = nil
            keyWindow = nil
        }
    }
    
    func windowWillEnterFullScreen(_ notification: Notification) {
        // print(className + " : " + #function)
        guard let window = windowController?.window as? TTWindow else { return }
        window.tmp_isFullScreen = true
    }
    
    func windowDidEnterFullScreen(_ notification: Notification) {
        // print(className + " : " + #function)
        guard let window = windowController?.window as? TTWindow else { return }
        window.windowDidFullScreen()
    }
    
    func windowWillExitFullScreen(_ notification: Notification) {
        // print(className + " : " + #function)
        guard let window = windowController?.window as? TTWindow else { return }
        window.tmp_isFullScreen = false
    }
    
    func windowDidExitFullScreen(_ notification: Notification) {
        // print(className + " : " + #function)
        guard let window = windowController?.window as? TTWindow else { return }
        window.windowDidFullScreen()
    }
}
