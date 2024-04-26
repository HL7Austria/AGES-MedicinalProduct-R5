import minify_html
from pathlib import Path

print(list(Path('./output/').rglob('*.html')))

for file_name in Path('./output/').rglob('*.html'):
    print(file_name)
    with open(file_name, 'r') as file:
        text = file.read()
        # https://github.com/wilsonzlin/minify-html
        minified = minify_html.minify(text, minify_css=True, minify_js=True, remove_processing_instructions=True)

    with open(file_name, 'w') as file:
        file.write(minified)