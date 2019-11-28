#!/usr/bin/env python3

import subprocess
import sys
import imageio
from pathlib import Path
import argparse
# Argument parser.
description = '''Convert pngs to gif'''
parser = argparse.ArgumentParser(description=description)
parser.add_argument('input', nargs='+', help='Input files or dir')
parser.add_argument('--every',
                    '-e',
                    required=False,
                    default=1,
                    type=int,
                    help="Use every nth file")
parser.add_argument('--output',
                    '-o',
                    required=False,
                    default='animation.gif',
                    help='Output file')
parser.add_argument('--fps',
                    '-f',
                    required=False,
                    default=4,
                    type=int,
                    help='Frames per second.')


class Args:
    pass


args = Args()
parser.parse_args(namespace=args)

inputs = args.input
if len(inputs) == 1:
    # it is a directory?
    inputs = [str(x) for x in Path(inputs[0]).glob('**/*.png')]

print(f"Total  {len(inputs)} files found. Selecting every {args.every}th.")
files = inputs[::args.every]
imgs = [imageio.imread(f) for f in files]
print(f"→ Writing to {args.output}")
imageio.mimwrite(args.output, imgs, fps=args.fps)