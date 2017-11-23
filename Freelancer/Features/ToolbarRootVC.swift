//
//  ViewController.swift
//  Animations
//
//  Created by Cyril on 13/04/17.
//  Copyright © 2017 Cyril. All rights reserved.
//

import UIKit
import SnapKit
import RAMAnimatedTabBarController

protocol ToolbarRootVCDelegate: class {
    func didSelectMyProjects(at vc: ToolbarRootVC)
    func didSelectBrowse(at vc: ToolbarRootVC)
    func didSelectProfile(at vc: ToolbarRootVC)
}

class ToolbarRootVC: BaseVC {

    weak var delegate: ToolbarRootVCDelegate?
    
    let containerView = UIView()
    let toolbar = UIToolbar()
   
    var myProjectsItem = UIBarButtonItem()
	var profileItem = UIBarButtonItem()
    var browseItem = UIBarButtonItem()
	
    var currentlySelectedItem: UIBarButtonItem? {
        willSet {
            self.currentlySelectedItem?.customView?.tintColor = .black
        }
        didSet {
            self.currentlySelectedItem?.customView?.tintColor = UIColor.flBlue()
        }
    }
    
    let myProjectsVC = MyProjectsVC()
    let userProfileVC = UserProfileVC()
    let browseVC = BrowseVC()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initToolbar()
        self.createContainer()
		self.title = "BROWSE PROJECTS"
		self.navigationController?.isNavigationBarHidden = false
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
    }
    
    fileprivate func createContainer() {
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        self.containerView.backgroundColor = .red
        containerView.snp.makeConstraints { (make) in
            make.left.leading.equalTo(self.view)
            make.right.trailing.equalTo(self.view)
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-44)
        }
    }
    
    fileprivate func initToolbar() {
        self.toolbar.backgroundColor = UIColor.white
		self.toolbar.tintColor = UIColor.black
        self.myProjectsItem = UIBarButtonItem()
		let myProjectsView = self.createImageView(withImageName: "folder", andSelector: #selector(self.didSelectMyProjects))
		self.myProjectsItem.customView = myProjectsView
		
        self.browseItem = UIBarButtonItem()
		let browseView = self.createImageView(withImageName: "search", andSelector: #selector(self.didSelectBrowse))
		self.browseItem.customView = browseView
		self.currentlySelectedItem = self.browseItem
		
        self.profileItem = UIBarButtonItem()
        let profileView = self.createImageView(withImageName: "profile", andSelector: #selector(self.didSelectProfile) )
        profileItem.customView = profileView
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        ///Setting up items HERE
        toolbar.items = [space, browseItem, space, space, myProjectsItem, space,space, profileItem, space]
        self.view.addSubview(toolbar)
        toolbar.snp.makeConstraints { (make) in
            make.left.leading.equalTo(self.view)
            make.right.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
		
		self.addVCToContainer(self.browseVC)
    }
	
	@objc func didSelectMyProjects() {
		self.currentlySelectedItem = self.myProjectsItem
		self.delegate?.didSelectMyProjects(at: self)
	}
	
    @objc func didSelectBrowse() {
        self.currentlySelectedItem = self.browseItem
        self.delegate?.didSelectBrowse(at: self)
    }
	
    @objc func didSelectProfile() {
        self.currentlySelectedItem = self.profileItem
        self.delegate?.didSelectProfile(at: self)
    }

    
    fileprivate func createImageView(withImageName name: String, andSelector  selector: Selector) -> UIImageView {
		guard let image = UIImage(named: name) else { print("Image \(name) not found!"); return UIImageView() }
		
        let tintedImage = image.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: tintedImage)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector))
        return imageView
    }
    
    
    func addVCToContainer(_ vc: UIViewController) {
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        UIView.transition(with: containerView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.containerView.addSubview(vc.view)
            self.addChildViewController(vc)
            vc.view.snp.makeConstraints { (make) in make.edges.equalTo(self.containerView) }
            vc.didMove(toParentViewController: self)
        }, completion: nil)
    }
    
    fileprivate func moveIndicatorTo(itemView: UIView) {
        self.makeDefaultImageColors()
        UIView.animate(withDuration: 1, animations: {
            self.toolbar.layoutIfNeeded()
        }, completion: { completed in
            if completed {
                if let imageView = itemView as? UIImageView {
                    imageView.tintColor = .red
                    imageView.zoomInAndOut()
                }
            }
        })
    }
    
    fileprivate func makeDefaultImageColors() {
        for item in [self.browseItem, self.myProjectsItem, self.profileItem, self.profileItem] {
            if let imageView = item.customView as? UIImageView {
                if imageView.tintColor == UIColor.red {
                    UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
                        imageView.tintColor = .black
                    }, completion: nil)
                } else {
                    imageView.tintColor = .black
                }
            }
        }
    }
    
}

