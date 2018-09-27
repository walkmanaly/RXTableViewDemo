//
//  ViewController.swift
//  RXTableViewDemo
//
//  Created by Nick on 2018/9/27.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var musicLists = MusicList()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(editClick))
        
        musicLists.data.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (index, music, cell) in
            // configcell
            print("\(index)   \(music.name)   \(music.song)")
            cell.textLabel?.text = music.name
            cell.detailTextLabel?.text = music.song
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { (music) in
                    print(music)
                }
            ).disposed(by: disposeBag)
        
        tableView.rx.modelDeleted(Music.self).subscribe(onNext: { (music) in
            print(music)
            
        }).disposed(by: disposeBag)
}
    
    @objc func editClick() {
        if tableView.isEditing {
            self.navigationItem.rightBarButtonItem?.title = "edit"
        } else {
            self.navigationItem.rightBarButtonItem?.title = "done"
        }
        tableView.isEditing = !tableView.isEditing
    }

}

