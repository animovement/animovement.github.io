# build.py
import pathlib, re

root = pathlib.Path(__file__).parent
template_path = root / "index.template.html"
output_path = root / "index.html"
partials_dir = root / "partials"

html = template_path.read_text()

def repl(match):
    filename = match.group(1).strip()
    part_path = partials_dir / filename
    if part_path.is_file():
        return part_path.read_text()
    print(f"⚠️ Missing {part_path}")
    return f"<!-- missing {filename} -->"

html = re.sub(r'<!--\sPLACEHOLDER:\s(.+?)\s-->', repl, html)
output_path.write_text(html)
print("✅ Built index.html")