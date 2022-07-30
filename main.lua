function xuehua(jsonurl)
    cachedir = string.gsub(gg.FILES_DIR,"files","cache")
    shell = newShell(true)
    xuehuajson=json.decode(gg.makeRequest(jsonurl)["content"])
    function execute(name)
        if name == "使命召唤" then
            executename = "tempcod"
            path = "大杂烩纯c版-解压出来后再执行"
        end
        if name == "未来之翼" then
            executename = "temppubg2"
            path = "大杂烩纯c版-解压出来后再执行"
        end
        if name == "PUBG" then
            executename = "temppubg"
            path = "大杂烩纯c版-解压出来后再执行"
        end
        if name == "暗区突围" then
            executename = "tempaqtw"
            path = "大杂烩纯c版-解压出来后再执行"
        end
        if name == "穿越火线" then
            executename = "temp1"
            path = "大杂烩纯c版-解压出来后再执行"
        end
        if name == "APEX国际服" then
            executename = "tempapex"
            path = "大杂烩纯c版-解压出来后再执行"
        end
        if name == "APEX港服" then
            executename = "tempapex2"
            path = "大杂烩纯c版-解压出来后再执行"
        end
        if name == "王者荣耀" then
            executename = "temp2"
            path = "王者荣耀纯c测试版-解压出来后再执行"
        end
        shell.cmd("cp "..cachedir.."/xh/"..path.."/lib/temp /data/tempp")
        shell.cmd("cp "..cachedir.."/xh/"..path.."/lib/"..executename.." /data/tempp2")
        shell.cmd("chmod 777 /data/tempp")
        shell.cmd("chmod 777 /data/tempp2")
        gg.toast("已启动大杂烩")
        gg.toast(shell.cmd("cd "..cachedir.."/xh/"..path.." && /data/tempp"))
    end
    function getxuehua(url)
        gg.toast("正在下载雪花纯c")
        data=gg.makeRequest(url)
        if data == nil then
            if data["code"]~=200 then
                gg.alert("雪花包下载失败")
            end
        end
        data=data["content"]
        io.open(gg.FILES_DIR.."/xuehua.zip","w"):write(data)
        gg.toast("解压ing...")
        shell.cmd("/data/adb/magisk/busybox unzip -o "..gg.FILES_DIR.."/xuehua.zip -d "..cachedir.."/xh/")
        shell.cmd("echo '"..tostring(xuehuajson['versionCode']).."' >"..cachedir.."/xh/version")
        xuehuaversion=xuehuajson['versionCode']
        gg.toast("雪花纯c下载初始化完成✓")
        gg.alert("公告:\n"..gg.makeRequest(xuehuajson['changelog'])["content"])
    end
    if io.open(cachedir.."/xh/version","rb") then
        xuehuaversion = io.open(cachedir.."/xh/version","r"):read("*a")
    else
        getxuehua(xuehuajson['zipUrl'])
    end
    if xuehuajson['versionCode'] > xuehuaversion then
        gg.toast("检测到版本更新")
        getxuehua(xuehuajson['zipUrl'])
    end
    shell.cmd("mkdir "..cachedir.."/xh")
    while true do
        if gg.isVisible(true) then
            s=1
            gg.setVisible(false)
        end
        gg.clearResults()
        if s==1 then
            s=-1
            xuehualist=gg.choice({
            "手动更新雪花纯c版本",
            "使命召唤",
            "未来之翼",
            "PUBG",
            "暗区突围",
            "穿越火线",
            "APEX国际服",
            "APEX港服",
            "王者荣耀",
            "退出"
            },nil,"一键开启雪花纯c\n当前雪花版本:"..xuehuajson['version'])
            if xuehualist then
                if xuehualist == 1 then
                    getxuehua(url)
                end
                if xuehualist == 2 then
                    execute("使命召唤")
                end
                if xuehualist == 3 then
                    execute("未来之翼")
                end
                if xuehualist == 4 then
                    execute("PUBG")
                end
                if xuehualist == 5 then
                    execute("暗区突围")
                end
                if xuehualist == 6 then
                    execute("穿越火线")
                end
                if xuehualist == 7 then
                    execute("APEX国际服")
                end
                if xuehualist == 8 then
                    execute("APEX港服")
                end
                if xuehualist == 9 then
                    execute("王者荣耀")
                end
                if xuehualist == 10 then
                    os.exit()
                end
            end
        end
    end
end
xuehua("https://ghproxy.com/https://raw.githubusercontent.com/heinu112/cloud/xuehua/xuehua.json")
