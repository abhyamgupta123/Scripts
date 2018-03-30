#!/bin/bash -
#===============================================================================
#
#          FILE: pandoc_find_filters.sh
#
#         USAGE: ./pandoc_find_filters.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Dilawar Singh (), dilawars@ncbs.res.in
#  ORGANIZATION: NCBS Bangalore
#       CREATED: 03/30/2018 06:25:32 PM
#      REVISION:  ---
#===============================================================================

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PANDOC_FILTERS="-F $SCRIPT_DIR/pandoc/dilawar.py "
if which pandoc-citeproc -v > /dev/null; then
    PANDOC_FILTERS="$PANDOC_FILTERS -F pandoc-citeproc"
fi
if which pandoc-crossref -v > /dev/null; then
    PANDOC_FILTERS="$PANDOC_FILTERS -F pandoc-crossref"
fi

if which pandoc-imagine > /dev/null; then
    PANDOC_FILTERS="$PANDOC_FILTERS -F pandoc-imagine"
fi

if which pantable2csv > /dev/null; then
    PANDOC_FILTERS="$PANDOC_FILTERS -F pantable"
fi
echo $PANDOC_FILTERS