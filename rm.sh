git filter-branch --force --index-filter \
'git rm --cached --ignore-unmatch middleware/index.php' \
--prune-empty --tag-name-filter cat -- --all
