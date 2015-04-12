///////////////////////////////////////////////////////////////////////////////

一个简单的富文本 Label for Cocos2d-x Lua

在 Cocos2d-x 3.5 下测试通过

///////////////////////////////////////////////////////////////////////////////
	
用法

	local txt = RichTextEx:create() -- 或 RichTextEx:create(26, cc.c3b(10, 10, 10))
	txt:setText("<#333>你好<#800>&lt;世<*2>界</2>&gt;<#DDD><+10><blink 闪烁></2><#F0F><rotate 旋转><#050><scale 缩放><img res/temp.png><img_50*50 res/temp.png><33bad_fmt<#555><64>Big<#077><18>SMALL")
	
	-- 多行模式要同时设置 ignoreContentAdaptWithSize(false) 和 contentSize
	txt:setMultiLineMode(true)	-- 这行其实就是 ignoreContentAdaptWithSize(false)
	txt:setContentSize(200, 400)
	
	addChild(txt)
	
基本选项是
	<#F00> = <#FF0000> 	= 文字颜色
	<32>				= 字体大小
	<img filename>		= 图片（filename 可以是已经在 SpriteFrameCache 里的 key，或磁盘文件）
	<img_32*32 fname> 	= 指定大小的图片
	<+2> <-2> <*2> </2> = 当前字体大小 +-*/
	<!>					= 颜色和字体大小恢复默认
	\n \t 				= 换行 和 tab，可能暂时实现得不是很好
	
示例选项是 (在 RichTextEx.defaultCb 中提供)
	<blink 文字>			= （动画）闪烁那些文字
	<rotate 文字>		= （动画）旋转那些文字
	<scale 文字>			= （动画）缩放那些文字
	(但如果你做了 setText(t, callback) 除非你在 callback 主动调用 defaultCb，否则以上选项会被忽略)	
	
TODO 或自己自行可扩展
	<img_w*h http://path/image> 从网络下载图片
	...
	
同时支持自定义特殊语法，加入 callback 回调就可，如

	txt:setText("XXXXX <aaaa haha> <bbbb> <CCCC> xxx", function(text, sender) -- 第二个参数 sender 可选
		-- 对每一个自定义的 <***> 都会调用此 callback
		-- text 就等于 *** (不含<>)
		-- 简单的返回一个 Node 的子实例就可，如
		-- 第二个参数 sender，可获取当前文字大小、颜色: sender._fontSize、sender._textColor
		
		if string.sub(text, 1, 4) == "aaaa" then
			return ccui.Text:create("aaa111" .. string.sub(text, 6)), "", 32)
		elseif text == "bbbb" then
			-- 用当前文字大小和颜色
			local lbl = ccui.Text:create("bbb111", "", sender._fontSize)
			lbl:setTextColor(sender._textColor)
			return lbl
		elseif string.sub(text, 1, 4) == "CCCC" then
			local img = ccui.ImageView:create(....)
			img:setScale(...)
			img:runAction(...)
			return img
		end
	end)
	
	
	
///////////////////////////////////////////////////////////////////////////////
	
ccext/RichTextEx.lua	是主文件
RichTextExCtrl.lua     	是 for Studio 2.2.1 的 Lua 自定义控件示例，依赖前一个文件

cocos/ 					是从 Cocos2d-x Lua copy 过来的，要用到里面的一些函数、定义
res/ 					是自己放图片的地方

这些目录构造是为了方便跟自己真实项目目录一致

///////////////////////////////////////////////////////////////////////////////

1、在 Cocos2d-x Lua/Quick Lua 里用时，只需主文件 ccext/RichTextEx.lua 就可

2、在 Studio 2.2.1 里做自定义控件时，把以上所有文件、文件夹 Copy 到对应目录，如

    (Windows)   X:\CocosDocuments\Cocos\CocosStudio2\Addins\LuaScript
    (Mac OSX)   ~/Library/Application Support/Cocos/CocosStudio2/Addins/LuaScript
   
   然后重启 Studio 后，在“自定义控件”面板上你会看到 RichTextExCtrl   

///////////////////////////////////////////////////////////////////////////////

具体用法在  RichTextEx.lua 里有说明

