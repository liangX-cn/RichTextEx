--[[
-------------------------------------------------------------------------------
By liangX.cn@qq.com 
Copyleft 20150410 随便使用
-------------------------------------------------------------------------------
	
Studio 2.2.1 Lua 自定义控件（依赖 RichTextEx.lua）

Studio 自定义控件 是把这两个文件放到平台对应目录，重启 Studio

	(Windows)	X:\CocosDocuments\Cocos\CocosStudio2\Addins\LuaScript
	(Mac OSX)	~/Library/Application Support/Cocos/CocosStudio2/Addins/LuaScript

--]]

--/////////////////////////////////////////////////////////////////////////////
-- 依赖 Cocos2d-x Lua Framework
-- require("cocos.init)
if nil == cc.size then
	require "cocos.cocos2d.Cocos2d"
	require "cocos.cocos2d.Cocos2dConstants"
	require "cocos.cocos2d.functions"
end
if nil == ccui.TextureResType then
    require "cocos.ui.GuiConstants"
    require "cocos.ui.experimentalUIConstants"
end

--/////////////////////////////////////////////////////////////////////////////
-- 依赖 RichTextEx.lua
local RichTextEx = require("ccext.RichTextEx")

--/////////////////////////////////////////////////////////////////////////////
-- Studio 自定义控件
local _C = {}

function _C.CreateCustomNode()
	local str = "<#333>你好<#800>\n&lt;世<*2>界</2>&gt;<#DDD><+10><blink 闪烁></2><#F0F><rotate 旋转><#050><scale 缩放><img res/temp.png><img_50*50 res/temp.png><33bad_fmt<#555><64>Big<#077><18>SMALL<"
	
	local txt = RichTextEx:create()
	txt:setText(str)	
--	local txt = ccui.Text:create(str, "", 32)
--	
--	txt:setText(str, function(text, sender) 
--		return sender.defaultCb(text, sender)
--	end)
	
	-- 多行模式要同时设置 ignoreContentAdaptWithSize(false) 和 contentSize
--	txt:setMultiLineMode(true)	-- 这行其实就是 ignoreContentAdaptWithSize(false)
--	txt:setContentSize(200, 400)

	return txt
end

function _C.GetBaseType()
    return 'Text'
end

--/////////////////////////////////////////////////////////////////////////////

return _C
