#!/bin/sh
#
# Copyright (c) 2015 The Linux Foundation. All rights reserved.
# Permission to use, copy, modify, and/or distribute this software for
# any purpose with or without fee is hereby granted, provided that the
# above copyright notice and this permission notice appear in all copies.
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
# OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

#@sfe_dump
#@example : sfe_dump (ipv4|ipv6)
sfe_dump() {
	local type="$1"

	text -n "$type" || return

	if [ ! -e "/dev/sfe_ipv4" ] ; then
		dev_num=$(cat /sys/sfe_ipv4/debug_dev)
		mknod /dev/sfe_ipv4 c $dev_num 0
	fi

	if [ ! -e "/dev/sfe_ipv6" ] ; then
		dev_num=$(cat /sys/sfe_ipv6/debug_dev)
		mknod /dev/sfe_ipv6 c $dev_num 0
	fi

	cat "/dev/sfe_$1"
}

if [ -n "$1" ] ; then
	sfe_dump "$1"
else
	sfe_dump ipv4
	sfe_dump ipv6
fi
