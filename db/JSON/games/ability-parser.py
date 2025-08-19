#!/usr/bin/env python3
import re
import json
import sys

def extract_abilities(block):
    """
    Return a list of abilities by looking for:
      1) “New: Ability1 / Ability2”  — must start with a letter, contain a slash
      2) “Old:  Ability1 / Ability2”  — same restrictions
      3) bare “Ability1 / Ability2”   — letter-only, with at least one slash
    """
    # 1) New: ability line (letter only, at least one slash)
    m = re.search(
        r"^New:\s*([A-Za-z][A-Za-z ']*(?:\s*/\s*[A-Za-z][A-Za-z ']*)+)$",
        block,
        re.MULTILINE
    )
    if not m:
        # 2) Old: ability line
        m = re.search(
            r"^Old:\s*([A-Za-z][A-Za-z ']*(?:\s*/\s*[A-Za-z][A-Za-z ']*)+)$",
            block,
            re.MULTILINE
        )
    if not m:
        # 3) bare slash-list (no digits)
        m = re.search(
            r"^([A-Za-z][A-Za-z ']*(?:\s*/\s*[A-Za-z][A-Za-z ']*)+)$",
            block,
            re.MULTILINE
        )

    if not m:
        return []

    # split on “/” and strip whitespace
    text = m.group(1)
    return [a.strip() for a in text.split("/") if a.strip()]

def parse_mastersheet(text):
    """
    Find every Pokémon block defined as:
      ===…===
      ID - Name
      ===…===
      (all the lines until the next ===…=== or end)
    Return a dict Name → [abilities].
    """
    header_re = re.compile(
        r"^={3,}\n"               # line of ===…
        r"(\d+)\s*-\s*(.+)\n"     # “ID – Name”
        r"={3,}\n",               # line of ===…
        re.MULTILINE
    )

    abilities_map = {}
    pos = 0

    for m in header_re.finditer(text):
        # m.start() is beginning of header; m.end() is after second === line
        name = m.group(2).strip()
        block_start = m.end()
        # look for next header
        next_m = header_re.search(text, block_start)
        block_end = next_m.start() if next_m else len(text)
        block = text[block_start:block_end]
        abilities_map[name] = extract_abilities(block)

    return abilities_map

def main():
    if len(sys.argv) != 2:
        print("Usage: python parse_abilities.py <mastersheet.txt>", file=sys.stderr)
        sys.exit(1)

    with open(sys.argv[1], 'r', encoding='utf-8') as f:
        text = f.read()

    abilities = parse_mastersheet(text)

    json.dump(abilities, sys.stdout, indent=2, ensure_ascii=False)

if __name__ == "__main__":
    main()
