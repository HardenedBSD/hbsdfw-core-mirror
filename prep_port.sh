#!/bin/sh

pfile=""

while getopts 'f:' o; do
	case "${o}" in
		f)
			pfile="${OPTARG}"
			;;
	esac
done

if [ -z "${pfile}" ]; then
	echo "[-] Set pkg-plist file with -f" 1>&2
	exit 1
fi

make plist | sed -e 's,/usr/local/,,g' -e 's,@sample ,,g' -e 's,@shadow ,,g' | sort | uniq > ${pfile}
