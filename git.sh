# 目的：批量初始化本地仓库为git仓库并上传至远程仓库
# 原理：判断当前目录下的所有一级文件夹内是否含有.git文件
# 二次运行效果：给出所有文件夹内的远端仓库地址

# 获取当前目录下的所有文件夹
folders=$(find . -maxdepth 1 -type d -not -path '*/\.*' -not -name '.')

# 遍历每个文件夹
for folder in $folders; do
    # 获取文件夹名称
    folder_name=$(basename "$folder")
    echo "进入$folder_name"
    # 进入文件夹
    cd "$folder"
    # 检查是否有.git文件夹
    if [ ! -d ".git" ]; then
        # 如果没有.git文件夹，则初始化git仓库
        git init
        # 添加远程仓库
        echo "$folder_name 添加远程仓库"
        git remote add origin "git@github.com:Chen-K-ang/$folder_name.git"
        # 添加所有文件到暂存区
        git add .
        # 提交到本地仓库
        git commit -m "master"
        # 推送到远程仓库
        git push -u origin master
    else
        git remote -v
    fi

    # 返回上级目录
    cd ..
done

