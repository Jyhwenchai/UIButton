import UIKit

//: UIButton 内部布局算法
//:
//: 以下称 `imageTextSpacing` 在 image 与 title 的间距，`titleInsets` 为 UIButton 的 `titleEdgeInsets`, `imageInsets` 在 UIButton 的 `imageEdgeInsets`, `contentInsets` 为 UIButton 的 `contentEdgeInsets`

let button = UIButton()
var titleInsets = button.titleEdgeInsets
var imageInsets = button.imageEdgeInsets
var contentInsets = button.contentEdgeInsets
var buttonSize = button.sizeThatFits(CGSize.zero)
let imageTextSpacing: CGFloat = 0
let titleSize = button.titleLabel!.sizeThatFits(CGSize.zero)
let imageSize = button.imageView!.sizeThatFits(CGSize.zero)

func reset() {
    titleInsets = button.titleEdgeInsets
    imageInsets = button.imageEdgeInsets
    contentInsets = button.contentEdgeInsets
    buttonSize = button.sizeThatFits(CGSize.zero)
}

//: ### 左 image 右 title
//:
//: (左 image 右 title) → 居中对齐 (默认), 参考线在中间 ━━┇━━
//:
//: 在当前布局上将 `image` 左移 `imageTextSpacing / 2`, `title` 右移 `imageTextSpacing / 2`, `buttonSize.width` 增加 `imageTextSpacing` 即可
example(of: "(左 image 右 title) → 居中对齐 (默认) + 间距") {
    imageInsets.left = -imageTextSpacing / 2.0
    imageInsets.right = imageTextSpacing / 2.0
    titleInsets.left = imageTextSpacing / 2.0
    titleInsets.right = -imageTextSpacing / 2.0
    
    buttonSize.width += imageTextSpacing
}

//: (左 image 右 title) → 左对齐, 参考线在左侧 ┇━━━━
//:
//: 在当前布局上 `image` 由于默认就是贴近左侧所以保持不变，`title` 右移 `imageTextSpacing`,`buttonSize.width` 增加 `imageTextSpacing` 即可
example(of: "(左 image 右 title) → 左对齐 + 间距") {
    button.contentHorizontalAlignment = .left
    
    titleInsets.left = imageTextSpacing
    titleInsets.right = -imageTextSpacing
    imageInsets = UIEdgeInsets.zero
    
    buttonSize.width += imageTextSpacing
}

//: (左 image 右 title) → 右对齐, 参考线在右侧 ━━━━┇
//:
//: 在当前布局上 `title` 由于默认就是贴近右侧所以保持不变，`image` 左移 `imageTextSpacing`,`buttonSize.width` 增加 `imageTextSpacing` 即可
example(of: "(左 image 右 title) → 右对齐 + 间距") {
    button.contentHorizontalAlignment = .right
    
    titleInsets = UIEdgeInsets.zero
    imageInsets.left = -imageTextSpacing
    imageInsets.right = imageTextSpacing
    
    buttonSize.width += imageTextSpacing
}

reset()
//: ### 左 title 右 image
//:
//: 在初始布局上将 `title` 左移 `imageSize.width`，`image` 右移 `titleSize.width` 即可达到效果，当前没有间距。
example(of: "左 title 右 image → 居中对齐 (默认) + 无间距") {
    titleInsets.left = -imageSize.width
    titleInsets.right = imageSize.width
    imageInsets.left = titleSize.width
    imageInsets.right = titleSize.width
}

//: 下面在(左 title 右 image)基础上加上间距
//:
//: (左 title 右 image) → 居中对齐 (默认), 参考线在中间 ━━┇━━
//:
//: 在（左 title 右 image）基础上，`title` 左移 `imageTextSpacing / 2.0`, `image` 右移 `imageTextSpacing / 2.0`，`buttonSize.width` 增加 `imageTextSpacing` 即可
example(of: "(左 title 右 image) → 居中对齐 (默认) + 间距") {
    titleInsets.left -= imageTextSpacing / 2.0
    titleInsets.right += imageTextSpacing / 2.0
    imageInsets.left += imageTextSpacing / 2.0
    imageInsets.right -= imageTextSpacing / 2.0
}

//: (左 title 右 image) → 左对齐, 参考线在左侧 ┇━━━━
//:
//: 在（左 title 右 image）基础上，`title` 贴近左侧所以保持不变, `image` 右移 `imageTextSpacing`，`buttonSize.width` 增加 `imageTextSpacing` 即可
example(of: "(左 title 右 image) → 左对齐 + 间距") {
    imageInsets.left += imageTextSpacing
    imageInsets.right -= imageTextSpacing
    
    buttonSize.width += imageTextSpacing
}

//: (左 title 右 image) → 右对齐, 参考线在右侧 ━━━━┇
//:
//: 在（左 title 右 image）基础上，`image` 贴近右侧所以保持不变, `title` 左移 `imageTextSpacing`，`buttonSize.width` 增加 `imageTextSpacing` 即可
example(of: "(左 title 右 image) → 右对齐 + 间距") {
    titleInsets.left -= imageTextSpacing
    titleInsets.right += imageTextSpacing
    
    buttonSize.width += imageTextSpacing
}

reset()
//: ### 上 image 下 title
//:
//: (上 image 下 title) → 居中对齐 (默认), 参考线在中间 ━━┇━━
//:
//: 需要将 `image` 右移 `titleSize.width / 2`，`title` 左移 `imageSize.width` 实现左右居中，然后将 `image` 上移 `titleSize.height / 2`, `title` 下移 `imageSize.height / 2` 实现上下居中，修改高度为 `titleSize.height + imageSize.height` 最终达到目的。
example(of: "（上 image 下 title）→ 居中对齐 (默认) + 无间距") {
    
    let titleHOffset = imageSize.width / 2.0
    let imageHOffset = titleSize.width / 2.0
    let titleVOffset = imageSize.height / 2.0
    let imageVOffset = titleSize.height / 2.0
    
    titleInsets = UIEdgeInsets(top: titleVOffset, left: -titleHOffset, bottom: -titleVOffset, right: titleHOffset)
    imageInsets = UIEdgeInsets(top: -imageVOffset, left: imageHOffset, bottom: imageVOffset, right: -imageHOffset)
    
    buttonSize.height = imageSize.height + titleSize.height
}

//: 下面在(上 image 下 title)基础上加上间距
//:
//: (上 image 下 title) → 居中对齐 (默认), 参考线在中间 ━╋━
//:
//: 在当前布局基础上将 `image` 上移 `mageTextSpacing / 2`，`title` 下移 `mageTextSpacing / 2`，buttonSize.height` 增加 `imageTextSpacing` 即可
example(of: "(上 image 下 title) → 居中对齐 (默认) + 间距") {
    imageInsets.top -= imageTextSpacing / 2.0
    imageInsets.bottom += imageTextSpacing / 2.0
    titleInsets.top += imageTextSpacing / 2.0
    titleInsets.bottom -= imageTextSpacing / 2.0
    
    buttonSize.height += imageTextSpacing
}

reset()

//: (上 image 下 title) → 上对齐, 参考线在顶部  ┳
//:
//: 由于是顶部对齐所以默认 `image` 与 `title` 都是贴近顶部，所以设置 `image` 距离顶部在0, `title` 在当前布局基础上下移 `imageSize.height` 实现上（image 下 title) ，然后再将 `title` 下移 `imageTextSpacing` 实现间距，最后 设置 buttonSize.height` 为 `imageSize.height + titleSize.height + imageTextSpacing` 即可
example(of: "(上 image 下 title) → 上对齐 + 间距") {
    
    button.contentVerticalAlignment = .top
    
    imageInsets.top = 0
    imageInsets.bottom = 0
    titleInsets.top = imageSize.height
    titleInsets.bottom = -imageSize.height
    
    titleInsets.top += imageTextSpacing
    titleInsets.bottom -= imageTextSpacing
    
    buttonSize.height = imageSize.height + titleSize.height + imageTextSpacing
}

reset()
//: (上 image 下 title) → 下对齐, 参考线在底部  ┻
//:
//: 由于是底部对齐所以默认 `image` 与 `title` 都是贴近底部，所以设置 `title` 距离底部在0, `image` 在当前布局基础上上移 `titleSize.height` 实现上（image 下 title) ，然后再将 `image` 上移 `imageTextSpacing` 实现间距，最后 设置 `buttonSize.height` 为 `imageSize.height + titleSize.height + imageTextSpacing` 即可
example(of: "(上 image 下 title) → 上对齐 + 间距") {
    
    button.contentVerticalAlignment = .top
    
    titleInsets.top = 0
    titleInsets.bottom = 0
    imageInsets.top = -titleSize.height
    imageInsets.bottom = titleSize.height
    
    imageInsets.top -= imageTextSpacing
    imageInsets.bottom += imageTextSpacing
    
    buttonSize.height = imageSize.height + titleSize.height + imageTextSpacing
}
