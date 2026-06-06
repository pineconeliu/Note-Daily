@echo off
chcp 65001 >nul
:: ========== 配置区（请根据实际情况修改） ==========
set WINSCP_PATH="C:\Program Files (x86)\WinSCP\WinSCP.com"
set HOST=180.71.128.44
set USER=root
set PASS=292879
set REMOTE_DIR=/home
set PORT=22
:: =================================================

:: 自动获取桌面路径
set LOCAL_DIR=%USERPROFILE%\Desktop\test

:: 如果默认路径找不到，尝试另一个常见安装路径
if not exist %WINSCP_PATH% set WINSCP_PATH="C:\Program Files\WinSCP\WinSCP.com"
if not exist %WINSCP_PATH% (
    echo [错误] 未找到 WinSCP.com，请安装 WinSCP 或修改脚本中的 WINSCP_PATH。
    pause
    exit /b 1
)

echo 正在连接服务器并下载文件...
%WINSCP_PATH% /command ^
    "option batch on" ^
    "option confirm off" ^
    "open sftp://%USER%:%PASS%@%HOST%:%PORT% -hostkey=""*""" ^
    "get ""%REMOTE_DIR%/*"" ""%LOCAL_DIR%\""" ^
    "exit"

if %errorlevel% equ 0 (
    echo 下载完成！文件已保存到桌面。
) else (
    echo 下载过程中出现错误，请检查网络、账号密码及远程路径。
)
pause