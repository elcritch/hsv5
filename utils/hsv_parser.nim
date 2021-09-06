import htmlparser
import xmltree
import strtabs
import os
import strutils

import argparse

proc nodes_iters(node: XmlNode, ident: int) =
  for child in node.items():
    if child.kind == xnElement:
      echo "..".repeat(ident), " tag: ", child.tag(), " attrs: ", if not child.attrs().isNil: $child.attrs() else: "--"
      nodes_iters(child, ident+1)

proc run_parser(fl: string) =
  let html: XmlNode = loadHtml(fl)
  echo "hsv:file: ", $fl
  # echo "html: ", $hnodes
  nodes_iters(html, 0)

var cli = newParser:
  help("parsing utils")
  command("parse"):
    # option("-f", "--file")
    arg("file")
    run:
      run_parser(opts.file)

try:
  cli.run()
except UsageError:
  stderr.writeLine getCurrentExceptionMsg()
  quit(1)
