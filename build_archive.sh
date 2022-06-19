#!/bin/sh

vernum="2.10"
ofile=""
ptree=""

while getopts "o:p:v:" o;
do
	case "${o}" in
		o)
			ofile="${OPTARG}"
			;;
		p)
			ptree="${OPTARG}"
			;;
		v)
			vernum="${OPTARG}"
			;;
	esac
done

if [ -z "${ofile}" ]; then
	echo "[-] Specify output file with -o" 1>&2
	exit 1
fi

git archive --format=tar --prefix=hawksense-core-${vernum}/ HEAD | gzip > ${ofile}

if [ ! -z "${ptree}" ]; then
	(
		cd ${ptree}/cyberesi/hawksense-core
		make makesum
	)
fi
