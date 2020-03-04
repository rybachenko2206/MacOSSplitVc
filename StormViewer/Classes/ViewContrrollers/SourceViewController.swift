//
//  SourceViewController.swift
//  StormViewer
//
//  Created by Roman Rybachenko on 03.02.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//


import Cocoa


class SourceViewController: NSViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: NSTableView!
    
    
    // MARK: - Properties
    private var imageFiles: [ImageMetadata] = []
    
    
    // MARK: - Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    

    // MARK: - Actions
    @IBAction func addFilesAction(_ sender: Any) {
        guard let window = self.view.window else { return }
        
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["png", "jpeg", "jpg"]
        openPanel.showsHiddenFiles = false
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = true

        openPanel.beginSheetModal(for: window, completionHandler: { [weak self] response in
            guard response == NSApplication.ModalResponse.OK else { return }
//            self?.representedObject = openPanel.urls
            
            let items: [ImageMetadata] = openPanel.urls.compactMap({ ImageMetadata(fileUrl: $0) })
            self?.imageFiles.append(contentsOf: items)
            self?.tableView.reloadData()
        })
    }
    
       
    // MARK: - Private funcs
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

// MARK: - NSTableViewDataSource
extension SourceViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return imageFiles.count
    }
    
}

extension SourceViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let imageFile = imageFiles[safe: row],
            let cellView = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView
            else { return nil }
        cellView.textField?.stringValue = imageFile.name
        return cellView
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let selectedImage = imageFiles[safe: tableView.selectedRow],
            let splitVc = self.parent as? NSSplitViewController,
            let detailsVc = splitVc.children[1] as? DetailsViewController
            else { return }
        
        detailsVc.selectedImage = selectedImage
    }
    
}
