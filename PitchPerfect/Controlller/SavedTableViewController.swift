//
//  SavedTableViewController.swift
//  PitchPerfect
//
//  Created by Ammar AlTahhan on 28/12/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import AVFoundation

class SavedTableViewController: UITableViewController {
    
    var files: [URL] {
        let docs = try! FileManager.default.contentsOfDirectory(at: Constants.Files.Directories.first!, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
        return docs.filter({Constants.Files.Extenstions.contains($0.pathExtension)})
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.title = "Saved Files"
    }

    // MARK: - Private functions
    
    private func removeFile(at index: Int) -> Bool {
        do {
            try FileManager.default.removeItem(at: files[index])
        } catch {
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if let newCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") {
            cell = newCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        }
        
        let fileURL = files[indexPath.row]
        let asset = AVAsset(url: fileURL)
        let name = fileURL.lastPathComponent
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = "\(String(format: "%.2f", CMTimeGetSeconds(asset.duration))) seconds"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlaySoundsViewController.instantiateFromStoryboard()
        vc.recordedAudioURL = files[indexPath.row]
        vc.displayState = .notSavable
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            if removeFile(at: indexPath.row) {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            tableView.endUpdates()
        }
    }

}
