# -*- coding: utf-8 -*-
"""
    pygments.lexers.mips
    ~~~~~~~~~~~~~~~~~~~~

    Lexers for mips

    :copyright: Copyright 2006-2017 by the Pygments team, see AUTHORS.
    :license: BSD, see LICENSE for details.
"""

import re

from pygments.lexer import RegexLexer, include, bygroups, default, using, \
    this, words, combined
from pygments.token import Text, Comment, Operator, Keyword, Name, String, \
    Number, Punctuation, Other
# from pygments.util import get_bool_opt, iteritems
import pygments.unistring as uni

__all__ = ['MIPSLexer']


class MIPSLexer(RegexLexer):
    
    """
    Pygments Lexer for MIPS files (.s, .asm).
    """

    name = 'MIPS_Assembly'
    aliases = ['mips']
    filenames = ['*.s', '*.asm']
    mimetypes = ['text/asm']

    flags = re.DOTALL | re.UNICODE | re.IGNORECASE | re.MULTILINE

    tokens = {
        'commentsandwhitespace': [
            (r'\s+', Text),
            # (r'#', Comment),
            (r'#.*?\n', Comment.Single),
            # (r'/\*.*?\*/', Comment.Multiline)
        ],
        'root': [
            include('commentsandwhitespace'),
            # (r'(\.space|\.asciiz)\b', Keyword.Declaration),
            (r'(\.\d+|[0-9]+\.[0-9]*)([eE][-+]?[0-9]+)?', Number.Float),
            (r'0[bB][01]+', Number.Bin),
            (r'0[oO][0-7]+', Number.Oct),
            (r'0[xX][0-9a-fA-F]+', Number.Hex),
            (r'[0-9]+', Number.Integer),
            (r'\.\.\.|=>', Punctuation),
            (r'\+\+|--|~|&&|\?|:|\|\||\\(?=\n)|'
             r'(<<|>>>?|==?|!=?|[-<>+*%&|^/])=?', Operator),
            (r'[{(\[;,]', Punctuation),
            (r'[})\].]', Punctuation),
            # (r'(for|in|while|do|return|if|else)\b', Keyword, 'slashstartsregex'),
            # (r'(var|macro|function)\b', Keyword.Declaration, 'slashstartsregex'),
            (r'(add|sub|addu|subu|addi|addiu|div|rem|mul|b|j|jal|jr|beq|beqz|bne|bnez|bge|bgeu|'
                r'begz|bgt|bgtu|bgtz|ble|bleu|blez|blt|bltu|bltz|sltu|not|and|or|syscall|move|'
                r'la|lb|lw|li|sw|sh|sb)\b', Name.Builtin),
            (r'"(\\\\|\\"|[^"])*"', String.Double),
            (r"'(\\\\|\\'|[^'])*'", String.Single),
            (r'`', String.Backtick, 'interp'),
            (r'[$a-zA-Z_][\w.\-:$]*\s*[:=]\s', Name.Variable),
            (r'\$[$a-zA-Z_][\w.\-:$]*\s*[:=]\s', Name.Variable.Instance),
            (r'\$', Name.Other),
            (r'\$?[$a-zA-Z_][\w-]*', Name.Other),
        ],
        'interp': [
            (r'`', String.Backtick, '#pop'),
            (r'\\\\', String.Backtick),
            (r'\\`', String.Backtick),
            (r'\$\{', String.Interpol, 'interp-inside'),
            (r'\$', String.Backtick),
            (r'[^`\\$]+', String.Backtick),
        ],
        'interp-inside': [
            # TODO: should this include single-line comments and allow nesting strings?
            (r'\}', String.Interpol, '#pop'),
            include('root'),
        ],            

    }
