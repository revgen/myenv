#!/usr/bin/env bash
set -e

echo "Check cyrillic2latin"
echo "Message: Проверка транслитерации" | myenv cyrillic2latin \
| grep "^Message: Proverka transliteratsii"
echo "Check cyrillic2latin - success"
