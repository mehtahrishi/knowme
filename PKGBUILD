# Maintainer: Hrishi Mehta <mehtahrishi45@gmail.com>
pkgname=knowme
pkgver=1.0.5
pkgrel=1
pkgdesc="A fast, offline command-line tool that displays detailed system info with text-based ASCII art logos"
arch=('any')
url="https://github.com/mehtahrishi/knowme"
license=('MIT')
depends=('python' 'python-psutil' 'python-distro' 'python-py-cpuinfo' 'python-requests' 'python-gputil' 'python-screeninfo' 'python-ifaddr')
makedepends=('python-build' 'python-installer' 'python-wheel')
source=("$pkgname-$pkgver.tar.gz::https://github.com/mehtahrishi/knowme/archive/v$pkgver.tar.gz")
sha256sums=('SKIP')

build() {
    cd "$pkgname-$pkgver"
    python -m build --wheel --no-isolation
}

package() {
    cd "$pkgname-$pkgver"
    python -m installer --destdir="$pkgdir" dist/*.whl
}
