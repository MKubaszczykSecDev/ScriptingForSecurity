import re

def search_for(letter):
    matches = re.findall(letter, content)
    count = len(matches)
    
    if matches:
        print(f"The letter '{letter}' exists. Count: {count}")
    else:
        print(f"The letter '{letter}' does not exist.")

file_path = r'E:\college work\Level 8 HND\Semester 2\Working in CyberSec\apache_log'
with open(file_path, 'r') as file:
    content = file.read()
search_for("a")
search_for("z")
