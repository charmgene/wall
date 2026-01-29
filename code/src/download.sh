# All downloads from: https://github.com/charmgene/wall/
# Required release assets - upload these files to your GitHub releases:
#   - v2ray-linux-64.zip
#   - v2ray-linux-arm64-v8a.zip
#   - jq-linux-amd64, jq-linux-arm64
#   - geoip.dat, geosite.dat
#   - caddy_linux_amd64.tar.gz, caddy_linux_arm64.tar.gz
wall_repo="charmgene/wall"

get_latest_version() {
    case $1 in
    core)
        name=$is_core_name
        # Get version from wall repo releases
        url="https://api.github.com/repos/${wall_repo}/releases/latest?v=$RANDOM"
        ;;
    sh)
        # Script version check disabled for security
        err "脚本更新已禁用 (Script updates disabled for security)"
        return 1
        ;;
    caddy)
        name="Caddy"
        # Get version from wall repo releases
        url="https://api.github.com/repos/${wall_repo}/releases/latest?v=$RANDOM"
        ;;
    esac
    latest_ver=$(_wget -qO- $url | grep tag_name | grep -E -o 'v([0-9.]+)')
    [[ ! $latest_ver ]] && {
        err "获取 ${name} 最新版本失败."
    }
    unset name url
}
download() {
    latest_ver=$2
    [[ ! $latest_ver && $1 != 'dat' ]] && get_latest_version $1
    # tmp dir
    tmpdir=$(mktemp -u)
    [[ ! $tmpdir ]] && {
        tmpdir=/tmp/tmp-$RANDOM
    }
    mkdir -p $tmpdir
    case $1 in
    core)
        name=$is_core_name
        tmpfile=$tmpdir/$is_core.zip
        # Download v2ray core from wall repo
        link="https://github.com/${wall_repo}/releases/download/${latest_ver}/${is_core}-linux-${is_core_arch}.zip"
        download_file
        unzip -qo $tmpfile -d $is_core_dir/bin
        chmod +x $is_core_bin
        ;;
    sh)
        # Script updates disabled for security - do not download from 3rd party repo
        err "脚本更新已禁用 (Script updates disabled for security reasons)"
        return 1
        ;;
    dat)
        # Download geo data files from wall repo
        name="geoip.dat"
        tmpfile=$tmpdir/geoip.dat
        link="https://github.com/${wall_repo}/releases/latest/download/geoip.dat"
        download_file
        name="geosite.dat"
        tmpfile=$tmpdir/geosite.dat
        link="https://github.com/${wall_repo}/releases/latest/download/geosite.dat"
        download_file
        cp -f $tmpdir/*.dat $is_core_dir/bin/
        ;;
    caddy)
        name="Caddy"
        tmpfile=$tmpdir/caddy.tar.gz
        # Download Caddy from wall repo
        link="https://github.com/${wall_repo}/releases/download/${latest_ver}/caddy_${latest_ver:1}_linux_${caddy_arch}.tar.gz"
        download_file
        [[ ! $(type -P tar) ]] && {
            rm -rf $tmpdir
            err "请安装 tar"
        }
        tar zxf $tmpfile -C $tmpdir
        cp -f $tmpdir/caddy $is_caddy_bin
        chmod +x $is_caddy_bin
        ;;
    esac
    rm -rf $tmpdir
    unset latest_ver
}
download_file() {
    if ! _wget -t 5 -c $link -O $tmpfile; then
        rm -rf $tmpdir
        err "\n下载 ${name} 失败.\n"
    fi
}
