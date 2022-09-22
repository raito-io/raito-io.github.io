
SOURCE_FOLDER=${SOURCE_FOLDER:-_site}
SUB_FOLDER=${SUB_FOLDER:-_preview}

echo "removing ${SOURCE_FOLDER}/${SUB_FOLDER}"
rm -rf ${SOURCE_FOLDER}/${SUB_FOLDER}

echo "source: ${SOURCE_FOLDER}, destination: ${SOURCE_FOLDER}/${SUB_FOLDER}"

cp -r "$SOURCE_FOLDER" _temp
cp -r _temp "${SOURCE_FOLDER}/${SUB_FOLDER}"

rm -rf _temp

cd "${SOURCE_FOLDER}/${SUB_FOLDER}"
BACKUP_EXTENSION=""
# needed to run on Mac
if [[ "$OSTYPE" = darwin* ]]; then 
    BACKUP_EXTENSION=".bak"
fi

# necessary substitutions to have everything from _preview point to things in _preview
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf' | xargs sed -i $BACKUP_EXTENSION 's|/docs|/_preview/docs|g'
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf' | xargs sed -i $BACKUP_EXTENSION 's|/assets|/_preview/assets|g'
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i $BACKUP_EXTENSION 's|href="/"|href="/_preview/"|g'
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i $BACKUP_EXTENSION 's|href="/favicon.ico"|href="/_preview/favicon.ico"|g'
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i $BACKUP_EXTENSION 's|content: "/"|content: "/_preview/"|g'
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i $BACKUP_EXTENSION 's|rl": "/"|rl": "/_preview"|g'
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf'| xargs sed -i $BACKUP_EXTENSION 's|3E0A91|669900|g'
grep -r -l . * | grep -E -v 'jpg|ico|svg|png|webp|woff2|ttf' | xargs sed -i $BACKUP_EXTENSION 's|CF0863|FFCC00|g'


if [[ "$OSTYPE" = darwin* ]]; then 
    find . -name "*.bak" -type f -delete
fi