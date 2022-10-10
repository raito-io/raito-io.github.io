
SOURCE_FOLDER=${SOURCE_FOLDER:-_site}
SUB_FOLDER=${SUB_FOLDER:-_preview}

if [[ "$OSTYPE" = darwin* ]]; then 
    echo "Running locally, removing ./_site/_preview and creating a fresh copy"

    echo "removing ${SOURCE_FOLDER}/${SUB_FOLDER}"
    rm -rf ${SOURCE_FOLDER}/${SUB_FOLDER}

    echo "source: ${SOURCE_FOLDER}, destination: ${SOURCE_FOLDER}/${SUB_FOLDER}"

    cp -r "$SOURCE_FOLDER" _temp
    cp -r _temp "${SOURCE_FOLDER}/${SUB_FOLDER}"

    rm -rf _temp
fi 

echo "$> cd ${SOURCE_FOLDER}/${SUB_FOLDER}"
cd "${SOURCE_FOLDER}/${SUB_FOLDER}"
BACKUP_EXTENSION=".bak"

clean_backup() {
    find . -name "*.bak" -type f -delete
}

# necessary substitutions to have everything from _preview point to things in _preview

# main substituion replacing all the obvious /docs/ links
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf' | xargs sed -i"$BACKUP_EXTENSION" 's|/docs/|/_preview/docs/|g'
clean_backup

# also substitute links to assets
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf' | xargs sed -i"$BACKUP_EXTENSION" 's|/assets|/_preview/assets|g'
clean_backup

# substitute some trailing links (like / for navigation)
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i"$BACKUP_EXTENSION" 's|href="/"|href="/_preview/"|g'
clean_backup

# favicon substitution
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i"$BACKUP_EXTENSION" 's|href="/favicon.ico"|href="/_preview/favicon.ico"|g'
clean_backup

# for some of the css files
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i"$BACKUP_EXTENSION" 's|content: "/"|content: "/_preview/"|g'
clean_backup

# for search.json
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i"$BACKUP_EXTENSION" 's|rl": "/"|rl": "/_preview"|g'
clean_backup

# change theme to make it obvious that you're on a preview page
# grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i"$BACKUP_EXTENSION" 's|570ECA|669900|g'
# clean_backup
# grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf' | xargs sed -i"$BACKUP_EXTENSION" 's|CF0863|FFCC00|g'
# clean_backup


if [[ $(cat 404.html  | grep _preview | wc -l) -gt 0 ]]; then
    echo "Substitution successful"
fi