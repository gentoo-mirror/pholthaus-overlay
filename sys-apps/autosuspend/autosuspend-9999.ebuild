# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/languitar/${PN}.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/languitar/${PN}/archive/v${PV}.tar.gz"
fi

DESCRIPTION="A daemon to suspend and wake up a system based on configurable checks"
HOMEPAGE="https://github.com/languitar/autosuspend"
LICENSE="GPL-2"
SLOT="0"
IUSE="dbus doc mpd requests xml ical file iputils X"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/psutil
	dbus? ( dev-python/dbus-python[${PYTHON_USEDEP}] )
	mpd? ( >=dev-python/python-mpd-0.4.2[${PYTHON_USEDEP}] )
	requests? ( dev-python/requests[${PYTHON_USEDEP}] )
	xml? ( dev-python/lxml[${PYTHON_USEDEP}] )
	ical? ( dev-python/icalendar[${PYTHON_USEDEP}] dev-python/python-dateutil[${PYTHON_USEDEP}] dev-python/tzlocal[${PYTHON_USEDEP}] )
	iputils? ( net-misc/iputils )
	X? ( x11-misc/xprintidle )
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pytest-runner[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}] dev-python/sphinx-issues[${PYTHON_USEDEP}] )
	${PYTHON_DEPS}
"

python_compile_all() {
        use doc && esetup.py build_sphinx -a -b html
	use doc && esetup.py build_sphinx -a -b man
}

python_install_all() {
	distutils-r1_python_install_all
	mv "${D}/usr/etc" "${D}/"
	use doc && doman doc/build/man/autosuspend.1
	use doc && doman doc/build/man/autosuspend.conf.5
	use doc && dodoc -r doc/build/html
}
