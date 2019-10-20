//
//  ViewController.swift
//  UIButton
//
//  Created by ilosic on 2019/10/17.
//  Copyright © 2019 ilosic. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    enum LayoutMode {
        case leftImageRightText
        case leftTextRightImage
        case topImageBottomText
     }
     
    /// 这里的尺寸只适用与当系统字体未开启*粗体*的情况，通常情况下应该使用下面的方式来获取 size, 这里为了方便测试所以写死
    /// textSize = previewButton.titleLabel?.sizeThatFits(CGSize.zero)
    /// imageSize = previewButton.imageView?.sizeThatFits(CGSize.zero)
    let imageSize = CGSize(width: 30, height: 30)
    let textSize = CGSize(width: 112, height: 21)
    
    var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center
    var contentVerticalAlignment: UIControl.ContentVerticalAlignment = .center
    
    var layoutMode = LayoutMode.leftImageRightText
    
 
    @IBOutlet weak var previewButton: UIButton!
    
    @IBOutlet var titleInsetsTextFields: [UITextField]!
    @IBOutlet var imageInsetsTextFields: [UITextField]!
    @IBOutlet var contentInsetsTextFields: [UITextField]!
    
    @IBOutlet weak var expandWidthTextField: UITextField!
    @IBOutlet weak var expandHeightTextField: UITextField!
    
    @IBOutlet weak var imageTitleSpacingTextField: UITextField!
    
    @IBOutlet weak var previewButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var previewButtonHeightConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        previewButton.layer.borderColor = UIColor.red.cgColor
        previewButton.layer.borderWidth = 1.0
        
        previewButton.imageView?.layer.borderWidth = 1.0
        previewButton.imageView?.layer.borderColor = UIColor.magenta.cgColor
        
        previewButton.titleLabel?.layer.borderWidth = 1.0
        previewButton.titleLabel?.layer.borderColor = UIColor.blue.cgColor
               
         
    }

    @IBAction func applyButtonAction(_ sender: UIBarButtonItem) {
        updatePreviewButton()
    }
    
    
    // MARK: - Actions
    @IBAction func presetButtonAction(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController()
        
        let leftTextRightImage = UIAlertAction(title: "left text right image", style: .default) { _ in
            self.layoutLeftTextRightImage()
        }
        
        let topImageBottomText = UIAlertAction(title: "top image bottom text", style: .default) { _ in
            self.layoutTopImageBottomText()
        }
        
        let reset = UIAlertAction(title: "reset", style: .default) { _ in
            self.layoutLeftImageRightText()
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        
        alert.addAction(leftTextRightImage)
        alert.addAction(topImageBottomText)
        alert.addAction(reset)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func chooseHorizontalAlignment(_ sender: Any) {
        let alert = UIAlertController()
        
        let center = UIAlertAction(title: "Center", style: .default) { _ in
            self.updateContentHorizontalAlignment(alignment: .center)
            self.updateTextFieldsValue()
        }
        let left = UIAlertAction(title: "Left", style: .default) { _ in
           self.updateContentHorizontalAlignment(alignment: .left)
            self.updateTextFieldsValue()
        }
    
        let right = UIAlertAction(title: "Right", style: .default) { _ in
            self.updateContentHorizontalAlignment(alignment: .right)
            self.updateTextFieldsValue()
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
               
        alert.addAction(center)
        alert.addAction(left)
        alert.addAction(right)
        alert.addAction(cancel)
               
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func chooseVerticalAlignment(_ sender: Any) {
        let alert = UIAlertController()
               
        let center = UIAlertAction(title: "Center", style: .default) { _ in
            self.updatecontentVerticalAlignment(alignment: .center)
            self.updateTextFieldsValue()
        }
        
        let top = UIAlertAction(title: "Top", style: .default) { _ in
            self.updatecontentVerticalAlignment(alignment: .top)
            self.updateTextFieldsValue()
        }
   
        let bottom = UIAlertAction(title: "Bottom", style: .default) { _ in
            self.updatecontentVerticalAlignment(alignment: .bottom)
            self.updateTextFieldsValue()
        }
       
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
              
        alert.addAction(center)
        alert.addAction(top)
        alert.addAction(bottom)
        alert.addAction(cancel)
              
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeSpacingAction(_ sender: Any) {
        updateTextFieldsValue()
    }
   
    
}

/// MARK - 图片与文本的位置布局 LayoutMode
extension ViewController {
    
    /// LayoutMode.leftImageRightText
    func layoutLeftImageRightText() {
        self.layoutMode = .leftImageRightText
        
        self.updateTextField(textFields: self.titleInsetsTextFields, insets: UIEdgeInsets.zero)
        self.updateTextField(textFields: self.imageInsetsTextFields, insets:  UIEdgeInsets.zero)
        self.updateTextField(textFields: self.contentInsetsTextFields, insets:  UIEdgeInsets.zero)
        self.expandHeightTextField.text = "0";
        self.expandWidthTextField.text = "0";
        self.imageTitleSpacingTextField.text = "0"
        self.contentVerticalAlignment = .center
        self.contentHorizontalAlignment = .center
        self.updatePreviewButton()
    }
    
    /// LayoutMode.leftTextRightImage
    func layoutLeftTextRightImage() {
        self.layoutMode = .leftTextRightImage
       
        let titleHOffset = self.imageSize.width
        let imageHOffset = self.textSize.width
       
        let titleInsets = UIEdgeInsets(top: 0, left: -titleHOffset, bottom: 0, right: titleHOffset)
        let imageInsets = UIEdgeInsets(top: 0, left: imageHOffset, bottom: 0, right: -imageHOffset)
        let contentInsets = UIEdgeInsets.zero
       
        self.updateTextField(textFields: self.titleInsetsTextFields, insets: titleInsets)
        self.updateTextField(textFields: self.imageInsetsTextFields, insets: imageInsets)
        self.updateTextField(textFields: self.contentInsetsTextFields, insets: contentInsets)

        self.updatePreviewButton()
    }
    
    /// LayoutMode.topImageBottomText
    func layoutTopImageBottomText() {
        self.layoutMode = .topImageBottomText
        
        let titleHOffset = self.imageSize.width / 2.0
        let imageHOffset = self.textSize.width / 2.0
        let titleVOffset = self.imageSize.height / 2.0
        let imageVOffset = self.textSize.height / 2.0
        
        let titleInsets = UIEdgeInsets(top: titleVOffset, left: -titleHOffset, bottom: -titleVOffset, right: titleHOffset)
        let imageInsets = UIEdgeInsets(top: -imageVOffset, left: imageHOffset, bottom: imageVOffset, right: -imageHOffset)
        let contentInsets = UIEdgeInsets.zero
        
        self.updateTextField(textFields: self.titleInsetsTextFields, insets: titleInsets)
        self.updateTextField(textFields: self.imageInsetsTextFields, insets: imageInsets)
        self.updateTextField(textFields: self.contentInsetsTextFields, insets: contentInsets)

        self.updatePreviewButton()
    }
    
  
}

extension ViewController {
    
    func updateTextFieldsValue() {
        
        if layoutMode == .leftTextRightImage { layoutLeftTextRightImage() }
        if layoutMode == .topImageBottomText { layoutTopImageBottomText() }
        
        var titleInsets = convertInsets(textFields: titleInsetsTextFields)
        var imageInsets = convertInsets(textFields: imageInsetsTextFields)
        let imageTextSpacing = convert(input: imageTitleSpacingTextField.text!)

        
       switch layoutMode {
           /// 左图片右文本
           case .leftImageRightText:

               switch contentHorizontalAlignment {
               case .center:
                /// 目标：居中对齐，image 和 title 之间间距为 imageTextSpacing
                /// 实现：titleInsets 右移 imageTextSpacing / 2.0, imageInsets 左移 imageTextSpacing / 2.0，UIButton 宽度增加 imageTextSpacing
                titleInsets.left = imageTextSpacing / 2.0
                titleInsets.right = -imageTextSpacing / 2.0
                imageInsets.left = -imageTextSpacing / 2.0
                imageInsets.right = imageTextSpacing / 2.0
                
               case .left:
                /// 目标：左对齐，image 和 title 之间间距为 imageTextSpacing
                /// 实现：保持 imageInsets 不变，titleInsets 右移 imageTextSpacing
                titleInsets.left = imageTextSpacing
                titleInsets.right = -imageTextSpacing
                imageInsets = UIEdgeInsets.zero
                
               case .right:
                /// 目标：右对齐，image 和 title 之间间距为 imageTextSpacing
                /// 实现：保持 titleInsets 不变，imageInsets 左移 imageTextSpacing
                titleInsets = UIEdgeInsets.zero
                imageInsets.left = -imageTextSpacing
                imageInsets.right = imageTextSpacing
               default: break
            }
        
           /// 左文本右图片
           case .leftTextRightImage:
            
                switch contentHorizontalAlignment {
                   case .center:
                    
                    /// 目标：居中对齐，image 和 title 之间间距为 imageTextSpacing
                    /// 实现：在原基础上调整 titleInsets 左移 imageTextSpacing / 2.0, imageInsets 右移 imageTextSpacing / 2.0，UIButton 宽度增加 imageTextSpacing
                    titleInsets.left -= imageTextSpacing / 2.0
                    titleInsets.right += imageTextSpacing / 2.0
                    imageInsets.left += imageTextSpacing / 2.0
                    imageInsets.right -= imageTextSpacing / 2.0
                    
                   case .left:
                    /// 目标：右对齐，image 和 title 之间间距为 imageTextSpacing
                    /// 实现：保持 titleInsets 不变，imageInsets 左移 imageTextSpacing
                    imageInsets.left += imageTextSpacing
                    imageInsets.right -= imageTextSpacing
                    
                   case .right:
                    /// 目标：左对齐，image 和 title 之间间距为 imageTextSpacing
                    /// 实现：保持 imageInsets 不变，titleInsets 右移 imageTextSpacing
                    titleInsets.left -= imageTextSpacing
                    titleInsets.right += imageTextSpacing
               
                   default: break
                }
            case .topImageBottomText:
                
                let imageHeight = self.imageSize.height
                let textHeight = self.textSize.height
                
                switch contentVerticalAlignment {
                    case .center:
                        imageInsets.top -= imageTextSpacing / 2.0
                        imageInsets.bottom += imageTextSpacing / 2.0
                        titleInsets.top += imageTextSpacing / 2.0
                        titleInsets.bottom -= imageTextSpacing / 2.0
                    
                    case .top:
                        imageInsets.top = 0
                        imageInsets.bottom = 0
                        titleInsets.top = imageHeight
                        titleInsets.bottom = -imageHeight
                        
                        titleInsets.top += imageTextSpacing
                        titleInsets.bottom -= imageTextSpacing
                    
                    case .bottom:
                        titleInsets.top = 0
                        titleInsets.bottom = 0
                        imageInsets.top = -textHeight
                        imageInsets.bottom = textHeight
                        
                        imageInsets.top -= imageTextSpacing
                        imageInsets.bottom += imageTextSpacing
                    
                    default: break;
                }
       }
       
       updateTextField(textFields: titleInsetsTextFields, insets: titleInsets)
       updateTextField(textFields: imageInsetsTextFields, insets: imageInsets)
       
        /// 扩大 UIButton 宽度
        if layoutMode == .topImageBottomText {
            if convert(input: expandHeightTextField.text!) < imageTextSpacing {
                expandHeightTextField.text = "\(imageTextSpacing)"
            }
        } else {
            if convert(input: expandWidthTextField.text!) < imageTextSpacing {
                expandWidthTextField.text = "\(imageTextSpacing)"
            }
        }
       
        updatePreviewButton()
    }
    
    func updatePreviewButton() {
        
        let titleInsets = convertInsets(textFields: titleInsetsTextFields)
        let imageInsets = convertInsets(textFields: imageInsetsTextFields)
        let contentInsets = convertInsets(textFields: contentInsetsTextFields)
        let expandWidth = convert(input: expandWidthTextField.text!)
        let expandHeight = convert(input: expandHeightTextField.text!)

        previewButton.titleEdgeInsets = titleInsets
        previewButton.imageEdgeInsets = imageInsets
        previewButton.contentEdgeInsets = contentInsets
        
        previewButton.contentHorizontalAlignment = contentHorizontalAlignment
        previewButton.contentVerticalAlignment = contentVerticalAlignment
        
        print(titleInsets)
        print(imageInsets)
        print(contentInsets)
       
       
        let size = previewButton.sizeThatFits(CGSize.zero)
        
        switch layoutMode {
        case .leftImageRightText, .leftTextRightImage:
            self.previewButtonWidthConstraint.constant = size.width + expandWidth
            self.previewButtonHeightConstraint.constant = size.height + expandHeight
        case .topImageBottomText:
            self.previewButtonWidthConstraint.constant = size.width + expandWidth
            self.previewButtonHeightConstraint.constant = size.height + textSize.height + expandHeight
        }
        
        self.previewButton.setNeedsUpdateConstraints()
        self.previewButton.updateConstraintsIfNeeded()
        self.previewButton.setNeedsLayout()
        self.previewButton.layoutIfNeeded()
    }
    
    func updateTextField(textFields: [UITextField], insets: UIEdgeInsets) {
           textFields.first?.text = String(Double(insets.top))
           textFields[1].text = String(Double(insets.left))
           textFields[2].text = String(Double(insets.bottom))
           textFields.last?.text = String(Double(insets.right))
    }
       
    func updateContentHorizontalAlignment(alignment: UIControl.ContentHorizontalAlignment) {
       self.contentHorizontalAlignment = alignment
       self.updatePreviewButton()
    }
       
    func updatecontentVerticalAlignment(alignment: UIControl.ContentVerticalAlignment) {
          self.contentVerticalAlignment = alignment
          self.updatePreviewButton()
    }
    
    func convert(input: String) -> CGFloat {
        return CGFloat(Double(input) ?? 0.0)
    }
    
    func convertInsets(textFields: [UITextField]) -> UIEdgeInsets {
        let top = convert(input: textFields.first!.text!)
        let left = convert(input: textFields[1].text!)
        let bottom = convert(input: textFields[2].text!)
        let right = convert(input: textFields.last!.text!)
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
