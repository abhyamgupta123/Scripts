#!/usr/bin/env python

from __future__ import print_function

"""
Pandoc filter to process code blocks with class "graphviz", "chemfig",
"standalone" into pdf images.

Dependencies:
    - pygraphviz
    - lualatex
"""

import os
import sys
import re
import subprocess

from pandocfilters import toJSONFilter, Para, Image, get_filename4code, get_caption, get_extension

def print1( *msg ):
    print( msg, file=sys.stderr )

def replace_ext( filename, newext = 'tex' ):
    oldExt = filename.split( '.' )[-1]
    return re.sub( r'(.+?)\.%s$' % oldExt, '\1\.%s' % newext )

def gen_standalone( code, dest, fmt ):
    dest = os.path.realpath( dest )

    tex = [ '\\RequirePackage{luatex85,shellesc}' ]
    tex += [ '\\documentclass[tikz,multi=false]{standalone}' ]
    tex += [ '\\usepackage{chemfig}' ]
    tex += [ '\\usepackage{pgfplots}' ]
    tex += [ '\\begin{document}' ]
    tex += [ code ]
    tex += [ '\\end{document}']

    dirname = os.path.dirname( dest )
    basename = os.path.basename( dest )
    nameWE = '.'.join( basename.split( '.' )[:-1] )
    texFile = os.path.join( dirname, nameWE + '.tex' )

    # Write file
    with open( texFile, 'w' ) as f:
        f.write( '\n'.join( tex ) )

    os.chdir( dirname )
    res1 = subprocess.check_output( 
            [ 'lualatex', '-shell-escape', texFile ]
            , shell=False, stderr = subprocess.STDOUT 
            , cwd = dirname
            )

    if fmt != 'pdf':
        pdfFile = os.path.join( dirname, nameWE + '.pdf' )
        outfile = os.path.join( dirname, nameWE + '.%s' % fmt )
        res = subprocess.check_output( 
                [ 'convert', pdfFile, outfile ]
                , shell=False
                , stderr = subprocess.STDOUT
                , cwd = dirname
                )

    assert os.path.isfile( dest ), "%s could not be generated." % dest
    

def codeblocks(key, value, format, _):
    if key == 'CodeBlock':
        return process( value, format )

def process( value, format ):
    [[ident, classes, keyvals], code] = value
    if "graphviz" in classes:
        caption, typef, keyvals = get_caption(keyvals)
        filetype = get_extension(format, "png", html="png", latex="pdf")
        dest = get_filename4code("graphviz", code, filetype)

        if not os.path.isfile(dest):
            import pygraphviz
            g = pygraphviz.AGraph(string=code)
            g.layout()
            g.draw(dest)
            sys.stderr.write('Created image ' + dest + '\n')

        return Para([Image([ident, [], keyvals], caption, [dest, typef])])

    elif "standalone" in classes:
        caption, typef, keyvals = get_caption(keyvals)
        filetype = get_extension(format, "pdf", html="png", latex="pdf")
        dest = get_filename4code("standalone", code, filetype)
        if not os.path.isfile(dest):
            gen_standalone(code, dest, format)
            sys.stderr.write('Created image ' + dest + '\n')
        else:
            sys.stderr.write('Exists  ' + dest + '\n')

        return Para([Image([ident, [], keyvals], caption, [dest, typef])])


if __name__ == "__main__":
    toJSONFilter( codeblocks )