#!/bin/bash
# lets detect if gpgme is available if not, disable gpgme
which gpgme-config 2>/dev/null >/dev/null
if test $? -ne 0 ; then
	echo containers_image_openpgp
fi
